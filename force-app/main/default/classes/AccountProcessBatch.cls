global class AccountProcessBatch implements Database.Batchable<sObject> {

    // START
    global Database.QueryLocator start(Database.BatchableContext bc){

        return Database.getQueryLocator('SELECT Id, Name, AccountProcessed__c ' + 'FROM Account ' +'WHERE 	AccountProcessed__c = false');
    }

    // EXECUTE
    global void execute(Database.BatchableContext bc, List<Account> scope){

        for (Account acc : scope){
            acc.AccountProcessed__c = true;
        }
         
        DataBase.SaveResult[] results = DataBase.update(scope , false);
            
          for (Integer i = 0; i < results.size(); i++) {
            if (results[i].isSuccess()) {
                System.debug('Account updated: ' + scope[i].Id );
            } else {

                for (Database.Error err : results[i].getErrors()) {
                    System.debug('Account update failed: ' +scope[i].Id +' | ' +err.getMessage());
                }
            }
          }
        
        
        
        
        
        
        
    }

    // FINISH
    global void finish(Database.BatchableContext bc) {

        System.debug('Batch 1 completed.');

        // Start Batch 2
        Database.executeBatch( new ContactProcessBatch(),200);
    }
}