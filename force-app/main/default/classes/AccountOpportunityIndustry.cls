public class AccountOpportunityIndustry {

    
    public static void createAcc(List<Account> newAccounts){
        
        List<Opportunity> lo = new List<Opportunity>();
          
        for(Account ac : newAccounts){
            if(ac.Industry == 'Agriculture'){
                lo.add(new Opportunity(AccountId = ac.Id , Name = 'Test1' , StageName = 'Proposal' ,CloseDate = System.Today()+1, 
                                       Closing_Reason__c = 'I create this through Account'));
            }
            
        }
        
        
        if(!lo.isEmpty()){
            Insert lo;
        }
        
        
    }
    
    
    
    
    
    
}