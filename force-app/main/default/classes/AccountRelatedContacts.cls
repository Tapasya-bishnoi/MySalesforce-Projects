public with sharing class AccountRelatedContacts {
   @InvocableMethod( label='Get Related Contact Names'
    description='Returns Contact names associated with the selected Account'
    CapabilityType='PromptTemplateType://einstein_gpt__fieldCompletion'
    )
    public static List<Response> getContactNames(List<Request> requests) {
        List<Response> responses = new List<Response>();
        if (requests.isEmpty() || requests[0].RelatedEntity == null) {
            Response emptyResponse = new Response();
            emptyResponse.Prompt = 'No Account was provided.';
            responses.add(emptyResponse);
            return responses;
        }
        Id accountId = requests[0].RelatedEntity.Id;
        List<Contact> contacts = [SELECT Name, Email FROM Contact WHERE AccountId = :accountId ORDER BY Name];
        Response result = new Response();
        if (contacts.isEmpty()) {
            result.Prompt = 'No related Contacts found for this Account.';
        } else {
            List<String> contactDetails = new List<String>();
            for (Contact c : contacts){
                contactDetails.add('Name: ' + c.Name +(String.isBlank(c.Email) ? '' : ', Email: ' + c.Email));
            }
            result.Prompt = String.join(contactDetails, '\n');
        }
        responses.add(result);
        return responses;
    }
    public class Request {
        @InvocableVariable
        public Account RelatedEntity;
    }
    public class Response {
        @InvocableVariable
        public String Prompt;
    }
}
