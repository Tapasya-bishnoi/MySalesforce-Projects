global class DuplicateCleanupScheduler implements Schedulable {

    global void execute(SchedulableContext sc) {

        List<Contact> duplicateContacts = [
            SELECT Id,
                   Oiginal_Contact__c,
                   Duplicate_Detected_On__c
            FROM Contact
            WHERE Is_Duplicate__c = true
            AND Duplicate_Detected_On__c <= :System.now().addMinutes(-1)
        ];

        if (duplicateContacts.isEmpty()) {
            return;
        }

        Set<Id> duplicateIds = new Set<Id>();
        Map<Id, Id> duplicateToOriginal = new Map<Id, Id>();

        for(Contact c : duplicateContacts){
            if(c.Oiginal_Contact__c != null){
                duplicateIds.add(c.Id);
                duplicateToOriginal.put(c.Id, c.Oiginal_Contact__c);
            }
        }

        // Get Opportunities linked to duplicate Contact
        List<Opportunity> oppList = [
            SELECT Id, Name, Contact__c
            FROM Opportunity
            WHERE Contact__c IN :duplicateIds
        ];

        // Existing Contact Roles
        Map<String, OpportunityContactRole> existingRoles = new Map<String, OpportunityContactRole>();

        for(OpportunityContactRole role : [
            SELECT Id, OpportunityId, ContactId
            FROM OpportunityContactRole
            WHERE OpportunityId IN :oppList
        ]){
            existingRoles.put(role.OpportunityId + '-' + role.ContactId, role);
        }

        List<Opportunity> oppToUpdate = new List<Opportunity>();
        List<OpportunityContactRole> rolesToInsert = new List<OpportunityContactRole>();

        for(Opportunity opp : oppList){

            Id duplicateContact = opp.Contact__c;
            Id originalContact = duplicateToOriginal.get(duplicateContact);

            // Update Opportunity lookup
            opp.Contact__c = originalContact;
            oppToUpdate.add(opp);

            // Create Contact Role if not already present
            String key = opp.Id + '-' + originalContact;

            if(!existingRoles.containsKey(key)){

                OpportunityContactRole role = new OpportunityContactRole();
                role.OpportunityId = opp.Id;
                role.ContactId = originalContact;
                role.Role = 'Decision Maker';   // Change if needed
                role.IsPrimary = true;

                rolesToInsert.add(role);
            }
        }

        if(!oppToUpdate.isEmpty()){
            update oppToUpdate;
        }

        if(!rolesToInsert.isEmpty()){
            insert rolesToInsert;
        }

        delete duplicateContacts;
    }
}