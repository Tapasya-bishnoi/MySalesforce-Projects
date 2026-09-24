 global class OpportunityBatch implements Database.Batchable<SObject>, Database.Stateful {
 
    // These variables will retain their values
    // across multiple execute() transactions
    global Integer successCount = 0;
    global Integer failureCount = 0;
 
    // 1. START METHOD
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Id, Name, StageName ' +'FROM Opportunity'
        );
    }
 
    // 2. EXECUTE METHOD
    global void execute(Database.BatchableContext bc, List<Opportunity> scope) {
        // Example: processing the Opportunities
        for (Opportunity opp : scope) {
            opp.Description = 'Processed by Batch Apex';
        }
 
 
        // Database.update with allOrNone = false
        // allows some records to succeed even if others fail
        Database.SaveResult[] results = Database.update(scope, false);
 
        // Count successful and failed records
        for (Database.SaveResult result : results) {
            if (result.isSuccess()) {
                successCount++;
            } else {
                failureCount++;
            }
        }
    }
 
 
    // 3. FINISH METHOD
    global void finish(Database.BatchableContext bc) {
 
        // Create email
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
 
        email.setToAddresses(
            new String[] { 'pooniatapasya049@gmail.com' }
        );
 
        email.setSubject('Opportunity Batch Processing Summary');
 
        email.setPlainTextBody(
            'Batch Processing Completed\n\n' +
            'Total Successful: ' + successCount + '\n' +
            'Total Failed: ' + failureCount
        );
 
        Messaging.sendEmail(
            new Messaging.SingleEmailMessage[] { email }
        );
    }
}
