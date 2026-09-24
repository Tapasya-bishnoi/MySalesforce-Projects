public class AccMap1 {
    
    
    public void crtMap1(){
       
          Set<Id> li = new Set<Id>();
  
        
        for(Account ac: [SELECT id FROM Account where Rating = 'Hot'])
        {
              li.add(ac.id);
        }
        
        
             System.debug(li);        
    }
    

}