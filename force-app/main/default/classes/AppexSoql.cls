public class AppexSoql {
    
    public static void crtSoql(){
      AggregateResult [] rs = [SELECT Account.Name ,sum(Amount) FROM Opportunity GROUP BY Account.Name];
        
        System.debug(rs);
        
        for(AggregateResult ar : rs ){
            
            System.debug('my record is ='+ar.get('Name'));
            
        }
    
    }
    
    

}