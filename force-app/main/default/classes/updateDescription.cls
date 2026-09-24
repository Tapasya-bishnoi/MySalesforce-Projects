public class updateDescription{

    @future
    public static void updateDescp(List<Id> li){

       List<Account> la = [SELECT Id , Description FROM Account WHERE Id IN : li];
    
        for(Account ac : la){
            ac.Description = 'Processed Async';
            }
    
            update la ;
    
    }
    
   }