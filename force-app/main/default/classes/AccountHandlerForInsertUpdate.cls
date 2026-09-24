public class AccountHandlerForInsertUpdate{
    
    public static void InsertUpdate(List<Account>la ,Map<Id,Account>ma){
        
        for(Account a : la){
            
            if((ma==null && a.Industry == 'Media' && a.Industry !=null )||(a.Industry=='media' && ma.get(a.Id).Industry!=a.Industry))
            {
                a.Rating = 'Warm';
            }
            
        }
      }    
    
    
    
    

}