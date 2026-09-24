public class OpportunityClass{
    
    public static void changeWithUpdation(List<Opportunity> lo , Map<Id ,Opportunity> mo){
        
        for(Opportunity o : lo){
            if(o.Amount!=mo.get(o.Id).Amount)
            o.Description = 'old amount is ='+mo.get(o.Id).Amount+'and is updated to='+o.Amount;
        }
        
        
        
        
    }
    
    
    
    
    
    

}