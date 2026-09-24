public class Task41{
    
    public static Map<Id , List<Contact>>linkAccount(){
        
         Map<Id , List<Contact>> ma= new Map<Id , List<Contact>>();
       
       List<Account> listrelatedAccount = [SELECT id ,(SELECT id ,name FROM Contacts) FROM Account];
       
        for(Account a :listrelatedAccount){
           ma.put(a.id ,a.contacts);
        
        }
        System.debug('this is the value ='+ma);
        return ma ;
        
    } 
    
    
    
    

}