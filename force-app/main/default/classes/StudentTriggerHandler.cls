public class StudentTriggerHandler {

   
    public static void populateCourseRecord(List<Student__c> ls){
        
        for(Student__c st : ls){
            
            if(st.Visa_Status__c == 'verifyed'){
                if(st.Passport_Number__c == null){
                  st.Passport_Number__c  = '24782';  
              }
            }
            
        }
        
        
        
        
        
        
        
    }
    
    
    
    
    
}