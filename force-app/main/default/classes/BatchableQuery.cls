public with sharing class BatchableQuery implements Database.Batchable<SObject>{

    // START METHOD
    public Database.QueryLocator start( Database.BatchableContext context) {
        String mainQuery =  'SELECT Id, Name  FROM Account ';

        String st ='WHERE Name= \'pooniatapasya049@gmail.com\'';

        String finalQuery = mainQuery + st;

        return Database.getQueryLocator(finalQuery);
    }


    // EXECUTE METHOD
    public void execute(Database.BatchableContext context,List<SObject> scope){
        for (SObject record : scope){

            Account acc = (Account) record;

            System.debug('Account Id: ' + acc.Id);
            System.debug('Account Name: ' + acc.Name);
        }
    }


    // FINISH METHOD
    public void finish(
        Database.BatchableContext context
    ) {
        System.debug('Batch Job Finished');
    }
}