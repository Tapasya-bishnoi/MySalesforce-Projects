public with sharing class ContactController{
  @AuraEnabled(cacheable = true)
  public static List<Contact> listOfCon(String accId){
    try {
        return[
         SELECT AccountId , Id , FirstName , LastName
         From Contact 
         WHERE AccountId =: accId
WITH SECURITY_ENFORCED// automatic  enable object and field level security
 ];
    } catch (Exception e) {
        throw new AuraHandledException(e.getMessage());
    }
  }
















}