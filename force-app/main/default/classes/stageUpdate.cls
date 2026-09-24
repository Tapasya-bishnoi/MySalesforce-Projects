public class stageUpdate{

    @future
    public static void updateOpportunityStage(List<Id> oppIds) {

        List<Opportunity> oppList = [
            SELECT Id, StageName
            FROM Opportunity
            WHERE Id IN :oppIds
        ];

        for(Opportunity opp : oppList) {
            opp.StageName = 'Closed Won';
        }

        if(!oppList.isEmpty()){
            update oppList;
        }
    }
}