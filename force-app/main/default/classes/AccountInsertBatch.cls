public class AccountInsertBatch implements Database.Batchable<sObject>{
    
  
    public Database.Querylocator start(Database.BatchableContext bc){
        return Database.getQuerylocator('SELECT Id FROM USER LIMIT 1');
       }
    
    public static void execute(Database.BatchableContext bc , List<USER>lu){
        
          List<Account> la = new List<Account>();
        for(Integer i = 0 ; i<10 ; i++){
            la.add(new Account(Name ='Test ACCC'+i , Description = 'this is batch apex'));
        }
        
        if(!la.isEmpty()){
            insert la;
        }
    }
    
   
    public static void finish(Database.BatchableContext bc){
        System.debug('completed');
    }
    
    
    
    
    
    
    

}