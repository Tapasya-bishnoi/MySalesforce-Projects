public with sharing class OpenOpportunity {

    // Get all open Opportunities
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpenOpportunities() {

        return [
            SELECT Id, Name, StageName, Amount, CloseDate
            FROM Opportunity
            WHERE IsClosed = false
            ORDER BY CreatedDate DESC
        ];
    }


    // Update Opportunity Stage
    @AuraEnabled
    public static void updateOpportunityStage(Id opportunityId,String stage) {

        if (stage != 'Closed Won' && stage != 'Closed Lost') {
            throw new AuraHandledException('Invalid Stage');
        }

        Opportunity opp = [
            SELECT Id, StageName
            FROM Opportunity
            WHERE Id = :opportunityId
            LIMIT 1
        ];

        opp.StageName = stage;

        update opp;
    }
}