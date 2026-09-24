public class AccountBatch implements Database.Batchable<SObject> {

    public  Database.QueryLocator start(Database.BatchableContext bc) {
        
           System.debug('START METHOD CALLED');

        return Database.getQueryLocator('SELECT Id, Description FROM Account');
    }

    public void execute(Database.BatchableContext bc,List<Account> scope) {
            
        
          System.debug('EXECUTE METHOD CALLED');

        for(Account acc : scope) {
            acc.Description = 'Updated by Batch Job';
        }

        update scope;
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('Batch Completed');
    }
}