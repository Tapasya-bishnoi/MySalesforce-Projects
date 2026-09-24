public class OppProcessor implements Database.Batchable<sObject> , Database.stateful{
                                                                    //this is statemanagement of variable recordCount 
    public integer recordCount = 0 ;
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        
        return Database.getQueryLocator([SELECT Id , Name FROM Opportunity]);
    }
    
    public void execute(Database.BatchableContext bc , List<Opportunity>lo){
        
        for(Opportunity op: lo){
            op.LeadSource = 'DEV';
        }
         

      Update lo;
      recordCount = recordCount + lo.size();
 
 }
    
    public void finish(Database.BatchableContext bc){
        
        System.debug('processed record'+ recordCount);
    } 
    
}