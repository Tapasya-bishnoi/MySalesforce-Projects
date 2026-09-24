public class RegistrationTriggerHandler {

    public static void confirmationMail(List<Registration__c> regList){

        List<Messaging.SingleEmailMessage> emails =
        new List<Messaging.SingleEmailMessage>();

        for(Registration__c reg : regList) {

            Messaging.SingleEmailMessage mail =
            new Messaging.SingleEmailMessage();

            // Send To
            mail.setToAddresses(

                new List<String>{ reg.Email__c }

            );

            // Subject
            mail.setSubject(

                'Event Registration Confirmation'

            );

            // Email Body
            mail.setPlainTextBody(

                'Hello ' + reg.Name +

                'tapasya' +

                'Your registration has been confirmed successfully.' +

                'Thank You.'

            );

            emails.add(mail);

        }

        // Send Emails
        if(!emails.isEmpty()) {
           Messaging.sendEmail(emails);

        }

    }

}