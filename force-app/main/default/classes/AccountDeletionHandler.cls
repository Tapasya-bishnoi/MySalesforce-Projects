public class AccountDeletionHandler{
//
    
    public static void xyz(List<Contact> cl){
        
        List<Account> al = new List<Account>();
         Set<Id> si = new Set<Id>();
        
        for(Contact c : cl){
            if(c.AccountId!= null){
                si.add(c.AccountId);
            }
        }
       
        for(Account acc : [SELECT id , totalcount__c , (SELECT id FROM Contacts) FROM Account WHERE id IN:si]){
                            
                           acc.Totalcount__c =  acc.Contacts.size();
                           al.add(acc);
            
            
            
        }
        
        
          if(!al.isEmpty()){
            update al ;
        }
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
}