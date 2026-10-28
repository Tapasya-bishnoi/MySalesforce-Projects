public with sharing class OpportunityToPartner{
@AuraEnabled
public static String getFlexTemplateResponse(String OppName){
    // query Opportunity by Name from LWC 
    OppName = OppName+'%';
    Opportunity opp = [SELECT Id, Name FROM Opportunity WHERE Name like :OppName LIMIT 1];    
    List<string> roles = new List<string>();
     roles.add('System Integrator'); 
     roles.add('Developer');
    // query Partners
    LIST<Partner> partners = [select id,Role, Opportunity.name,AccountToId from Partner WHERE Opportunity.Name=: opp.Name and  Role IN : roles LIMIT 2];
        Map<String, String> opportunity = new Map<String, String>();
        opportunity.put('id', opp.Id);
        Map<String, String> SystemInegratorPartner = new Map<String, String>();
        SystemInegratorPartner.put('id', partners[0].AccountToId); 
        Map<String, String> DeveloperPartner = new Map<String, String>();
        DeveloperPartner.put('id',  partners[1].AccountToId);   
      // Build input map
    Map<String,ConnectApi.WrappedValue> wrapValues = new Map<String,ConnectApi.WrappedValue>();
        // Add wrapped values to map
        ConnectApi.WrappedValue opportunityWrapped = new ConnectApi.WrappedValue();
        opportunityWrapped.value = opportunity;
        ConnectApi.WrappedValue SystemInegratorWrapped = new ConnectApi.WrappedValue();
        SystemInegratorWrapped.value = SystemInegratorPartner;
        ConnectApi.WrappedValue DeveloperWrapped = new ConnectApi.WrappedValue();
        DeveloperWrapped.value = DeveloperPartner;    
        wrapValues.put('Input.Opportunity', opportunityWrapped);
        wrapValues.put('Input.SystemIntegrator', SystemInegratorWrapped);
 // Configure invocation parameters
     ConnectApi.EinsteinPromptTemplateGenerationsInput executeTemplateInput = new ConnectApi.EinsteinPromptTemplateGenerationsInput();
        executeTemplateInput.additionalConfig = new ConnectApi.EinsteinLlmAdditionalConfigInput();
        executeTemplateInput.additionalConfig.applicationName = 'PromptBuilderPreview';
        executeTemplateInput.isPreview = false;
        executeTemplateInput.inputParams = wrapValues;
        try {
            // Call the service
            // Call the service
        ConnectApi.EinsteinPromptTemplateGenerationsRepresentation generationsOutput = ConnectApi.EinsteinLLM.generateMessagesForPromptTemplate('Flex', executeTemplateInput);// Consume response
        System.debug('Prompt Testing: ' + generationsOutput.generations[0].text);
        return generationsOutput.generations[0].text;

        } catch (Exception e) {
            System.debug(e.getMessage());
            throw e;
        }
    }
}