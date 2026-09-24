public class DemoLoop {

    
    public static void crtD(){
        
      List<Account> li = new List<Account>();
        li = [SELECT id ,name FROM Account WHERE rating ='Hot'];
        
        if(!li.isEmpty()){
            
            for(Account a : li){
                
                a.industry = 'Media';
                
            }
            update li ;
            
        }
        
        
        
        
        
    }
    
    
    
    
}