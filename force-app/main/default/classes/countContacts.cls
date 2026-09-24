public class countContacts {

    @future
    public static void countContacts(List<Id>accIds){
        
        List<Account> accList = [SELECT Id ,(SELECT Id From Contacts) FROM Account WHERE Id IN :accIds];
        
        for(Account ac : accList){
            ac.Number_Of_Contacts__c = ac.Contacts.size();
        }
        
        if(!accList.isEmpty()){
            
            update accList ;
        
        }
        
        
        
    }
    
    
    
    
    
    
    
    
    
}