public class Task1 {
    
    public static Boolean fetchD(){
        List<Opportunity> lo = new List<Opportunity>();
          lo = [SELECT id , name ,stagename FROM Opportunity];
        
        for(Opportunity op: lo ){
            
            if(op.StageName == 'ClosedWon' || op.StageName == 'ClosedLost'){
                return true;
            }
            
        }
        
        return false;
       
    }
    
    
    

}