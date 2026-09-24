public with sharing class OpportunityImp {

    @AuraEnabled(cacheable=true)
    public static List<SBQQ__Quote__c> getQuotes(Id recordId){

        return [
            SELECT Id,
                   Name,
                   SBQQ__Status__c
            FROM SBQQ__Quote__c
            WHERE SBQQ__Opportunity2__c = :recordId
            ORDER BY CreatedDate DESC
        ];
    }
}