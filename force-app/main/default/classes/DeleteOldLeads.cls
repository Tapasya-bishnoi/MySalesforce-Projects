public with sharing class DeleteOldLeads implements Database.Batchable<SObject> {

    // START METHOD
    public Database.QueryLocator start( Database.BatchableContext context){

        // Find unconverted Leads not modified for more than 2 years
        String query = 'SELECT Id, Name, LastModifiedDate, IsConverted ' +'FROM Lead ' +'WHERE IsConverted = false ' +'AND CreatedDate = TODAY';
           return Database.getQueryLocator(query);
    }


    // EXECUTE METHOD
    public void execute(Database.BatchableContext context,List<SObject> scope){

        // Delete records without stopping the whole batch
        // if one record fails
        Database.DeleteResult[] results = Database.delete(scope, false);

        // Check deletion results
        for (Database.DeleteResult result : results) {

            if (result.isSuccess()) {

                System.debug(  'Lead deleted successfully: ' + result.getId() );

            } else {

        for (Database.Error error : result.getErrors()) {

            System.debug(  'Error deleting Lead: ' + error.getMessage());
        }
            }
        }
    }


    // FINISH METHOD
    public void finish( Database.BatchableContext context){
         System.debug('Old Leads deletion batch completed.');
    }
}