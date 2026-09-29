global class ContactProcessBatch implements Database.Batchable<sObject> {

    // START
    global Database.QueryLocator start(Database.BatchableContext bc) {

        return Database.getQueryLocator('SELECT Id, FirstName, LastName,ContactProcessed__c '+ 'FROM Contact '+ 'WHERE ContactProcessed__c = false');
    }

    // EXECUTE
    global void execute(Database.BatchableContext bc, List<Contact> scope){

        for(Contact con : scope){
            con.ContactProcessed__c= true;
        }

        update scope;
    }

    // FINISH
    global void finish(Database.BatchableContext bc){

        System.debug('Batch 2 completed.');
    }
}