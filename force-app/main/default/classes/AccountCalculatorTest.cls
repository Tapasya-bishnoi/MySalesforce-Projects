@isTest
public class AccountCalculatorTest {
    
   @isTest
    public static void accountlist(){
        
        List<Account> la = new  List<Account>();
        for(Integer i =0; i<125 ; i++){
            la.add(new Account(Name = 'Test'+i));
        }
        insert la;
        
                 
        List<Contact> lc = new List<Contact>();
         List<Id> accId = new List<Id>(); 
        for(Account ac: la){
            lc.add(new Contact(FirstName ='test' , LastName = ac.Name ,AccountId = ac.Id));
              accId.add(ac.Id);
            
        }
        
       insert lc; 
        
        
        Test.startTest();
        AccountCalculator.accountlist(accId);
        Test.stopTest();
        if(true){
        List<Account> le = [SELECT Id ,Number_Of_Contacts__c FROM Account];
         System.assertEquals(1 ,le[0].Number_Of_Contacts__c , 'this is not working');
        }
 }
    
}