public class AccountCalculator{
    
    @future
    public static void accountlist(List<Id> li){
        
    List<Account> la = [SELECT Id , (SELECT Id FROM Contacts) FROM Account WHERE Id IN : li];
        
        
        for(Account ac : la){
            ac.Number_Of_Contacts__c = ac.Contacts.size();
            }

              
        if(!la.isEmpty()){
            update la;
        }
        
}
}