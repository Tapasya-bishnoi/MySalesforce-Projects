public class SendEmailToContact {
    @future
    public static void sendEmail(List<Id> ids){

        List<Contact> contacts = [
            SELECT Id, Email, FirstName
            FROM Contact
            WHERE Id IN :ids
        ];

        List<Messaging.SingleEmailMessage> emails =
            new List<Messaging.SingleEmailMessage>();

        for(Contact con : contacts){

            if(con.Email != null){

                Messaging.SingleEmailMessage mail =
                    new Messaging.SingleEmailMessage();

                mail.setToAddresses(
                    new List<String>{con.Email}
                );

                mail.setSubject('Welcome');

                mail.setPlainTextBody(
                    'Hello ' + con.FirstName +
                    ', Welcome to our organization.'
                );

                emails.add(mail);
            }
        }

        if(!emails.isEmpty()){
            Messaging.sendEmail(emails);
        }
    }
}