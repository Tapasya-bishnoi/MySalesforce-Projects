public class OpportunityTriggerHandler {
     
    public static void descUpdate(List<opportunity>lo ,Map<Id , Opportunity>mo){
        
        List<Opportunity> lou = new List<Opportunity>();
        
        for(Opportunity op : lo){
            
            Opportunity o = new Opportunity();
            if(op.StageName!= mo.get(op.Id).StageName){
                if(op.StageName == 'Closed Won'){
                     o.id = op.Id;
                    op.Description = 'value is Closed Won';
                } else if(op.StageName == 'Closed Lost'){
                     o.id = op.Id;
                   op.Description =  'value is Closed Lost'; 
                }
                
            }
            
            
          lou.add(o); 
            
        }
        
        if(!lou.isEmpty()){
            update lou;
        }  
        
    }
    
    
    
    
    
    
    
    
}