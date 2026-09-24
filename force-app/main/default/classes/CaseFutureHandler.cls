public class CaseFutureHandler {

    @future
    public static void processHighPriorityCases(List<Id> caseIds){

        List<Case> casesToUpdate = new List<Case>();
        List<Task> tasksToCreate = new List<Task>();

        List<Case> caseRecords = [
            SELECT Id, CaseNumber, OwnerId
            FROM Case
            WHERE Id IN :caseIds
        ];

        for(Case c : caseRecords){

            // Update Escalation Flag
            Case updateCase = new Case(
                Id = c.Id,
              IsEscalated = true
            );
            casesToUpdate.add(updateCase);

            // Create Task
            Task t = new Task(
                Subject = 'High Priority Case Follow-up',
                Status = 'Not Started',
                Priority = 'High',
                WhatId = c.Id,
                OwnerId = c.OwnerId
            );
            tasksToCreate.add(t);
        }

        if(!casesToUpdate.isEmpty()){
            update casesToUpdate;
        }

        if(!tasksToCreate.isEmpty()){
            insert tasksToCreate;
        }

        // Notify Manager (Email)
        Messaging.SingleEmailMessage mail =
            new Messaging.SingleEmailMessage();

        mail.setToAddresses(
            new String[]{'manager@example.com'}
        );
        mail.setSubject('High Priority Case Alert');
        mail.setPlainTextBody(
            'One or more cases have been marked as High Priority.'
        );

        Messaging.sendEmail(
            new Messaging.SingleEmailMessage[]{mail}
        );
    }
}