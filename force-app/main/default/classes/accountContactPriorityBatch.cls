global class accountContactPriorityBatch implements Database.Batchable<SObject> {
 
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Id, Priority__c FROM Account'
        );
    }
 
    global void execute(Database.BatchableContext bc, List<Account> scope) {
 
        // Store Account Ids from the current batch
        Set<Id> accountIds = new Set<Id>();
 
        for (Account acc : scope) {
            accountIds.add(acc.Id);
        }
 
        // Aggregate Query: Count Contacts for each Account
        Map<Id, Integer> contactCountMap = new Map<Id, Integer>();
 
        for (AggregateResult ar : [
            SELECT AccountId accountId, COUNT(Id) contactCount
            FROM Contact
            WHERE AccountId IN :accountIds
            GROUP BY AccountId
        ]) {
            contactCountMap.put(
                (Id) ar.get('accountId'),
                (Integer) ar.get('contactCount')
            );
        }
 
        // Prepare Account records for update
        List<Account> accountsToUpdate = new List<Account>();
 
        for (Account acc : scope) {
 
            Integer contactCount = contactCountMap.containsKey(acc.Id)
                ? contactCountMap.get(acc.Id)
                : 0;
 
            if (contactCount > 5) {
                acc.Priority__c = 'High';
            } else {
                acc.Priority__c = 'Normal';
            }
 
            accountsToUpdate.add(acc);
        }
 
        // Bulk DML
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
 
    global void finish(Database.BatchableContext bc) {
        System.debug('Account Contact Priority Batch Completed');
    }
}