public with sharing class OpportunityController {

    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpenOpportunities() {

        return [
            SELECT Id, Name, StageName, Amount
            FROM Opportunity
            WHERE StageName != 'Closed Won'
            ORDER BY CreatedDate DESC
        ];
    }

    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getClosedWonOpportunities() {

        return [
            SELECT Id, Name, StageName, Amount
            FROM Opportunity
            WHERE StageName = 'Closed Won'
            ORDER BY CreatedDate DESC
        ];
    }
}