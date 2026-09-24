public class DemoList {

    public void crtList(){
        List<Account> li = new List<Account>();
        Account ac = new Account();
          ac.Name = 'dane';
          ac.Phone = '9034236478';
         
        li.add(ac);
        
        Account ac1 = new Account ();
         ac1.Name = 'dane1';
         ac1.Phone = '9812321312';
        li.add(ac1);
        
        insert li;
         

     System.debug('names list is ='+ li);
      
     
        
    
    }
    
    
    
}