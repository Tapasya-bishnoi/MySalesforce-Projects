@RestResource(urlMapping='/AccountAPI/*')
global with sharing class AccountAPI{

    @HttpGet
    global static Account getAccount() {

        RestRequest req = RestContext.request;
        String accountId = req.requestURI.substring(
            req.requestURI.lastIndexOf('/') + 1
        );

        return [SELECT Id, Name, Phone FROM Account  WHERE Id = :accountId LIMIT 1 ];

    }

    @HttpPost
    global static String createAccount() {
                        RestRequest req = RestContext.request;
                     String requestBody = req.requestBody.toString();
              Account acc = (Account)JSON.deserialize(requestBody, Account.class);
                   insert acc;
         return 'Account Created Successfully. Id = ' + acc.Id;



    }

    @HttpPut
    global static String updateAccount() {
        
        RestRequest req = RestContext.request;
           Account acc = (Account)JSON.deserialize(req.requestBody.toString(), Account.class);
            update acc;

                  return 'Account Updated Successfully';
    }

    @HttpPatch
    global static String patchAccount() {

        RestRequest req = RestContext.request;
         Account input = (Account)JSON.deserialize(req.requestBody.toString(), Account.class);

        Account acc = [ SELECT Id, Name, Phone FROM Account WHERE Id = :input.Id LIMIT 1];


           if(input.Name != null)
            acc.Name = input.Name;

           if(input.Phone != null)
            acc.Phone = input.Phone;
               update acc;
             return 'Account Patched Successfully';
        }

    @HttpDelete
    global static String deleteAccount() {

        RestRequest req = RestContext.request;

        String accountId = req.requestURI.substring(
            req.requestURI.lastIndexOf('/') + 1
        );

        Account acc = [ SELECT Id  FROM Account WHERE Id = :accountId LIMIT 1 ];

           delete acc;
           
            
       return 'Account Deleted Successfully';      
        
    }

}