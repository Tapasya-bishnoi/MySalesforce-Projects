public class UpdateContactOwner {

    
    public static void updateOwn(List<Account> newAccounts){
        
        List<Contact> contactToUpdate = new List<Contact>();
        
          List<Contact> oldContactList = [SELECT Id,OwnerId ,AccountId FROM Contact];
        
        for(Account a:newAccounts){
            for(Contact cn :oldContactList){
                if(a.Id == cn.AccountId){
                   cn.OwnerId = a.OwnerId;
                    contactToUpdate.add(cn);
                }
                
            }
            
        }
        
        if(!contactToUpdate.isEmpty()){
            Update contactToUpdate; 
        }
        
        
        
    }
    
    
    
    
    
    
    
    
}