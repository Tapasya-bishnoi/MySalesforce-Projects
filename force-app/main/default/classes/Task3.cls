public class Task3 {
    
    public static Map<String , Integer>sumOfOpp(){
           
        
        List<AggregateResult> lo = new  List<AggregateResult>();
          Map<String , Integer> mo = new Map<String ,Integer>();
            
           lo = [SELECT StageName,COUNT(Id) totalcount FROM Opportunity GROUP BY StageName];
        
        for(AggregateResult op : lo){
            
        String st = (String)op.get('StageName');
         Integer xy = (Integer)op.get('totalcount');
            mo.put(st,xy);
            
           
            
        }
       System.debug('data is ='+mo);       
    return mo;
       
        
         }

}