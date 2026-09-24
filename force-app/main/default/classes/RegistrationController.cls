public with sharing class RegistrationController{
 
 @AuraEnabled
   public static void registration(String Email, String Name , String registrationStatus ,
    String AssociatedEvent){
          
       User ui = [SELECT Id , Profile.Name FROM User WHERE Id =: UserInfo.getUserId()
       ];
       
       if(ui.Profile.Name != 'Event Attendee'){
        throw new AuraHandledException('it cant be registered');
       }
      
         Registration__c rc = new Registration__c();
           rc.Associated_event__c = AssociatedEvent;
           rc.Email__c = Email;
           rc.Name = Name;
           rc.Registration_status__c = registrationStatus;
            
           insert rc;
   


   }



   @AuraEnabled(cacheable=true)
public static List<Event__c> getEvents() {
    return [
        SELECT Id, Name
        FROM Event__c
        ORDER BY Name
    ];
}
 }