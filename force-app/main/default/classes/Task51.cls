public class Task51{

    
    public static Map<Id , List<Case>> trackingCase(){
        
        Map<Id , List<Case>> trackCase =new Map<Id , List<Case>>();
        List<Account> listData = new List<Account>();
        listData = [SELECT id ,(SELECT id ,status FROM Cases WHERE isClosed=true) FROM Account LIMIT 5];
        
        for(Account a :listData){
            if(a.Cases!= null && a.Cases.size()<=5){
                trackCase.put(a.id ,a.Cases);
            }
            
            
            
        }
        System.debug('linked data is ='+trackCase);
        return trackCase;
        
        
    }
    
    
    
    }