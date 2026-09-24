public with sharing class OpportunityGlobalActionController {

    @AuraEnabled(cacheable=true)
    public static List<RecordType> getOpportunityRecordTypes() {

        return [
            SELECT Id, Name, DeveloperName
            FROM RecordType
            WHERE SObjectType = 'Opportunity'
            AND IsActive = true
            AND DeveloperName IN ('long_details', 'short_details')
            ORDER BY Name
        ];
    }
}