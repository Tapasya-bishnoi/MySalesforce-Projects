public with sharing class TaskGlobalActionController {

    @AuraEnabled(cacheable=true)
    public static List<RecordType> getTaskRecordTypes() {

        return [
            SELECT Id, Name, DeveloperName
            FROM RecordType
            WHERE SObjectType = 'Task'
            AND IsActive = true
            AND Name IN ('HighPrority', 'Low Priority')
            ORDER BY Name
        ];
    }
}