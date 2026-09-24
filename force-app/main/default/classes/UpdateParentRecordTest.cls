@isTest
public class UpdateParentRecordTest{
    
     @TestSetup
    public static void setup(){
        List<Account> la = new List<Account>();
         la.add(new Account(Name='Aatish'));
        
        for(Integer i =0; i<100 ; i++){
          la.add(new Account(Name ='Test Acc'+i)); 
        }
       insert la; 
    }
    
    @isTest
    public static void testData(){
        
        Id parentId =[SELECT Id FROM Account WHERE Name='Aatish'].Id;
        
        List<Account> accList =[SELECT Id, Name FROM Account WHERE Name LIKE 'Test Account%'];
        
        Test.startTest();
        System.enqueueJob (new UpdateParentRecord(accList,parentId));
        
        
        for(Account acc : [SELECT Id, ParentId FROM Account WHERE Name LIKE 'Test Account%']){
        
        System.assertEquals(parentId,acc.ParentId);
        
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}