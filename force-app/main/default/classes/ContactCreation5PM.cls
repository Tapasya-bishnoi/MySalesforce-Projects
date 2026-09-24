public class ContactCreation5PM{

  public static void crtCon(List<Account> newAccounts){

    List<Contact> newContacts = new List<Contact>();
      
      for(Account ac : newAccounts){
          
          newContacts.add(new Contact( LastName=ac.Name ,AccountId = ac.Id));
          
      }
      if(!newContacts.isEmpty()){
          insert newContacts;
      }       
    
    
    
    }
    
    
    
    
    
}