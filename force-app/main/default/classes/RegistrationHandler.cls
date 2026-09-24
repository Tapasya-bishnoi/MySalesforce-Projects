public class RegistrationHandler{

    
    public static void updateRecord(set<Id> eventId){
        List<Event__c> lc = new List<Event__c>();
        
        for(Event__c ec : [SELECT Id ,Maximum_members_capacity__c , AvailableSeat__c FROM Event__c WHERE Id IN : eventId]){
            
            Integer availS = [SELECT COUNT()  FROM Registration__c WHERE Associated_event__c =:ec.Id];
            
            
           ec.AvailableSeat__c = ec.Maximum_members_capacity__c - availS; 
            
            lc.add(ec);
            
        }
        
        if(!lc.isEmpty()){
            update lc;
        }
        
        
        
        
        
 }
    
    
    
    
}