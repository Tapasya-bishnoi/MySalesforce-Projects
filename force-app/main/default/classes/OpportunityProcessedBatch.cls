global class OpportunityProcessedBatch implements Database.Batchable<SObject> {

    global Database.QueryLocator start(Database.BatchableContext bc) {

        return Database.getQueryLocator('SELECT Id, Name,StageName,Processed__c ' +'FROM Opportunity ' + 'WHERE StageName = \'Closed Won\'');
    }


    global void execute( Database.BatchableContext bc,List<Opportunity> scope) {

        // Step 1: Update Processed__c
        for (Opportunity opp : scope) {
            opp.Processed__c = true;
             System.debug( opp.Name +  ' | Stage = ' + opp.StageName + ' | Processed AFTER = ' + opp.Processed__c);
        }

        // Step 2: Partial update
        Database.SaveResult[] results = Database.update(scope, false);

        // Step 3: Store errors
        List<Batch_Error_c__c> errorRecords = new List<Batch_Error_c__c>();

        for (Integer i = 0; i < results.size(); i++) {

            if (!results[i].isSuccess()) {

                for (Database.Error error : results[i].getErrors()) {

                    Batch_Error_c__c errorRecord = new Batch_Error_c__c();

                    errorRecord.Record_Id__c = scope[i].Id;
                    errorRecord.Error_Message__c = error.getMessage();
                    errorRecord.Batch_Name__c = 'OpportunityProcessedBatch';

                    errorRecords.add(errorRecord);
                }
            }
        }

        // Step 4: Insert error records
        if (!errorRecords.isEmpty()) {
            insert errorRecords;
        }
    }


    global void finish(Database.BatchableContext bc) {

        System.debug('Opportunity Processed Batch completed.');
    }
}