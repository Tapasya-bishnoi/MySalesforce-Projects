public class AccMap {
    
    public void crtMap(){
        
        Map<Id,Account> ma = new Map<Id,Account>();
         List<Account> li= new  List<Account>();
         li =  [SELECT id , name FROM Account LIMIT 4];
          ma.putAll(li);
        
        System.debug('map items is ='+ma);
        
      
        
        
    }

}