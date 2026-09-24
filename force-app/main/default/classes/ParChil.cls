public class ParChil {

    
    public static void crtPar(){
       
        List<Account> la = new List<Account>();
          
           la  = [SELECT id , name , (SELECT firstname , lastname FROM Contacts)FROM Account];
        for(Account a : la){
            
            System.debug('first record is ='+ a.id);
            for(Contact c : a.Contacts){
                System.debug('first contact record is ='+c.firstname+''+c.lastname);
            }
            
        }
        
        
        
    }
    
    
}