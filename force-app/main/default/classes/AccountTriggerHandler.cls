public class AccountTriggerHandler{
    
    public static void creatingOpp(List<Account> la){
        
        List<Opportunity> lo = new List<Opportunity>();
         
        for(Account acc: la){
            Opportunity o = new Opportunity();
            o.Name = acc.Name;
            o.StageName ='Closed Won';
            o.CloseDate = System.today();
            o.AccountId = acc.Id;
            lo.add(o);
        }
        
        if(!lo.isEmpty()){
            insert lo ;
        }
        
        
        
        
    }
    
    
    public static void preventionRecurrsion(List<Account> al , Map<Id , Account>ma){
        
        for(Account a : al){
            if(a.Id!= ma.get(a.Id).Id){
             a.Description = 'CHANGED for the recurrsion';   
            }
        }        
        
        
    }
    
    
    
    
    
    
    
    //public static void inserDescpsn(List<Account> li){
        
        //for(Account ac : li){
          //  ac.Description = 'this box is filled through apex class method';
       // }
  // }
    
    public static void populatedRating(List<Account> pr){
        
        for(Account acc : pr){
            
            if(acc.Industry!=null && acc.Industry=='Media'){
              acc.Rating = 'Cold'; 
            }
            
        }
        
        
    }
    
    

}