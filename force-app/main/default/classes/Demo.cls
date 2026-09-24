public class Demo {
    
    
    public static void crtD(){
        
      List<Account> li = new List<Account>();
        li = [SELECT id ,name FROM Account WHERE rating ='Hot'];
       
           delete li;
        
        
        if(!li.isEmpty()){
            
            for(Account a : li){
                
                a.industry = 'Media';
                
            }
       }
            Account ac = new Account();
        for(Integer i = 0; i<4 ;i++){
           ac.Name = 'record for upsert'+i;
            ac.Active__c = 'yes';
            li.add(ac);
        }
       
    }
    
    public static void crtDml(){
       
        List<Account> la = new List<Account>();
         List<Contact> lc = new  List<Contact>();
        
           Account ac = new Account();
            ac.Name = 'my first account dml4 ';
            ac.Active__c = 'Yes';
             la.add(ac);
           
        Account ac1 = new Account();
           ac1.Name  = 'my second account dml56';
           ac1.Active__c = 'yes';
            la.add(ac1);
             insert la;
        
        
        Contact con = new Contact();
          con.FirstName =ac.Name;
          con.LastName = ac.Name;
            con.AccountId = la[0].Id;
             lc.add(con);
           
        
          Contact con1 = new Contact();
          con1.FirstName = ac1.Name;
          con1.LastName = ac1.Name;
            con1.AccountId = la[1].Id;
         lc.add(con1);
        
        insert lc ;
        
        System.debug('acc.data is = '+la);
        System.debug('conn.data is = '+lc);
        
        
        
    
    
    
  }
    
    
    
    
    
    

}