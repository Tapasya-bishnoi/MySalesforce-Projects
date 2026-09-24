public class AccountFutureCallout {

    @future(callout=true)
    public static void sendAccountData(List<Id> accountIds){

        List<Account> accList = [
            SELECT Id, Name
            FROM Account
            WHERE Id IN :accountIds
        ];

        List<Account> updateAccounts = new List<Account>();

        for(Account acc : accList){

            try{

                Http http = new Http();

                HttpRequest request = new HttpRequest();

                request.setEndpoint(
                    'https://jsonplaceholder.typicode.com/posts'
                );

                request.setMethod('POST');

                request.setHeader(
                    'Content-Type',
                    'application/json'
                );

                String body ='{"accountName":"'+acc.Name+'"}';


                request.setBody(body);

                HttpResponse response =
                    http.send(request);

                System.debug(
                    'Response: ' +
                    response.getBody()
                );

                if(response.getStatusCode()==201){

                    Account upd =
                        new Account(
                            Id=acc.Id,
                            API_Status__c='Success'
                        );

                    updateAccounts.add(upd);

                }else{

                    Account upd =
                        new Account(
                            Id=acc.Id,
                            API_Status__c='Failed'
                        );

                    updateAccounts.add(upd);
                }

            }catch(Exception e){

                updateAccounts.add(
                    new Account(
                        Id=acc.Id,
                        API_Status__c=
                        'Error: '+e.getMessage()
                    )
                );
            }
        }

        if(!updateAccounts.isEmpty()){
            update updateAccounts;
        }
    }
}