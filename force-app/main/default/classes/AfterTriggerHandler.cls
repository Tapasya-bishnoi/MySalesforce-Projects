public class AfterTriggerHandler{

    public static void updateContactPhone(List<Account>la , Map<Id , Account>oldMap){
        
        List<Contact> lc = new List<Contact>();
        Map<Id , Account> mi = new  Map<Id , Account>();
        
         for(Account a : la){
            if(a.Phone!=oldMap.get(a.Id).Phone){
               mi.put(a.id , a);
              } 
             for(Contact c : [SELECT Id , HomePhone , AccountId FROM Contact WHERE AccountId IN: mi.keySet()]){
                c.HomePhone = mi.get(a.Id).Phone;
                 lc.add(c);
             }
         
             if(!lc.isEmpty()){
                 update lc ;
             }
            
        }
        
        
        
        
        
        
    } 
    
    
    
    
    
    
    
    
    
}