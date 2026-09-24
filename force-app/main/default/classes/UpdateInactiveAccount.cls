public with sharing class UpdateInactiveAccount  implements Database.Batchable<SObject> {

    // START METHOD
    public Database.QueryLocator start( Database.BatchableContext context) {

        String query ='SELECT Id, Active__c, Status__c ' + 'FROM Account ' + 'WHERE Active__c = \'No\'';
             return Database.getQueryLocator(query);
    }


    // EXECUTE METHOD
    public void execute(Database.BatchableContext context, List<SObject> scope
    ) {

        List<Account> accountsToUpdate = new List<Account>();

        for (SObject record : scope) {

            Account acc = (Account) record;

            acc.Status__c = 'Inactive';

            accountsToUpdate.add(acc);
        }

        if (!accountsToUpdate.isEmpty()) {

            update accountsToUpdate;
        }
    }


    // FINISH METHOD
    public void finish(Database.BatchableContext context){

        System.debug('Inactive Account Batch Job Completed');
    }
}