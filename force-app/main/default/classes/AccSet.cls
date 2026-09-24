public class AccSet {

    
    public void crtSet(){
        
        Set<Id> sa = new Set<Id>();
         List<Account> la = new List<Account>();
           la = [SELECT id FROM account LIMIT 5];
        
        for(Account a : la){
             sa.add(a.Id);
             }
        
        System.debug('id list is ='+sa);

        
    }
}