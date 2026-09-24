public with sharing class QuoteController {

    @AuraEnabled(cacheable=true)
    public static List<SBQQ__Quote__c> getQuotes(Id recordId) {

        return [
            SELECT
                Id,
                Name,
                SBQQ__Opportunity2__c,
                SBQQ__Status__c,
               SBQQ__NetAmount__c
            FROM SBQQ__Quote__c
            WHERE SBQQ__Opportunity2__c = :recordId
        ];
    }
}