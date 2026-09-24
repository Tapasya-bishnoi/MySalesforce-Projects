@isTest
public class OppProcessorTest{
    
     @isTest
   public static void testOpp(){
        List<Opportunity> lo = new List<Opportunity>();
       
       for(Integer i = 0 ; i<200 ; i++){
           
          lo.add(new Opportunity(Name ='test'+i, stageName='prospecting', CloseDate = System.today()));           
           
       }
       
            try{
               insert lo;
         }
             catch(Exception e){
              System.debug('ERROR = ' + e.getMessage());
               System.debug('STACK = ' + e.getStackTraceString());
                     }
        
        Test.startTest();
           OppProcessor op = new OppProcessor();
           Id  batchId = Database.executeBatch(op , 200);
          
           Test.stopTest();
                 
          List<Opportunity> li = [SELECT Id , Name FROM Opportunity WHERE LeadSource = 'DEV'];
                 
            System.assertEquals(200 , li.size());
                 
       
       
        
        
    }
    
    
    
    
    
    
    
    
    
    

}