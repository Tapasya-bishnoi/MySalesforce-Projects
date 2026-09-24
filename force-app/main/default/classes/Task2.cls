public class Task2 {
    
    
    public static Map<String ,List<Account>>groupingAccounts(){
           List<Account> la = new List<Account>();
        
         Map<String ,List<Account>> ma = new Map<String ,List<Account>>();
        
             la= [SELECT industry , name, id FROM Account];
        
        for(Account ac: la){
            if(!ma.containsKey(ac.Industry)){
                ma.put(ac.Industry ,new List<Account>());
            }
                ma.get(ac.Industry).add(ac);
            
        }
        System.debug('data is ='+ma);
      return ma;  
    }

}