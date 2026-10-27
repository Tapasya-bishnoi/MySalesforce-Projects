public class PromptAccountSummaryContactCount{
    // How to call that class 
    // How to get the values from PB
    // How can we feedback to PB
    @InvocableMethod(label='List of Contacts' description='Use to show the list of all contacts tagged to the Account. This class is called from a Prompt template' CapabilityType='PromptTemplateType://einstein_gpt__recordSummary')
    public static List<Response> listOfAccounts(List<Request> requests){
        // Validate the expected number of requests as an input        
        Account obAccount = requests[0].objectToSummarize;        
        List<contact> lstContact = [SELECT id, firstname, lastname from contact where AccountId = :obAccount.Id ];
        string responseData = null;
        if(lstContact.size() == 0){
            responseData = 'There Contact is tagged to the this Account.';
        }else{
            for(contact obC : lstContact){  
                responseData =  (responseData != null) ? responseData + '\n' : '';           
                responseData += String.format('Contact Name is : {0}, {1}.', new List<Object>{obC.firstname, obC.lastname});
            }
        }
        List<Response> responses = new List<Response>();
        Response res = new Response();
        res.Prompt = responseData;
        responses.add(res);
        return responses;
        }    
    public class Request{
        @InvocableVariable(required=true)
        public Account objectToSummarize;
    }    
    public class Response{
        @InvocableVariable
        public String Prompt;
    }    
}