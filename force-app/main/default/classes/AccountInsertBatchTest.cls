@isTest
public class AccountInsertBatchTest {

   @isTest
    public static void testInsertion(){
        
       Test.startTest();
        
        AccountInsertBatch ab = new  AccountInsertBatch();
        Id batchId = Database.executeBatch(ab);
      
        Test.stopTest();
        
       List<Account> li = [SELECT Id , Name , Description FROM Account WHERE Name LIKE 'Test ACCC%'] ;
        
        System.assertEquals(10 ,li.size());
        
        
        
        
        
 }
    
    
    
    
    
    
}