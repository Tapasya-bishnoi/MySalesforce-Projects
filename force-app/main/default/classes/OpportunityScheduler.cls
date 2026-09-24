public class OpportunityScheduler implements Schedulable {

    public void execute(SchedulableContext sc) {

        List<Opportunity> oppList = [SELECT Id, StageName, CloseDate FROM Opportunity WHERE StageName = 'Prospecting' AND CloseDate < TODAY];

        for(Opportunity opp : oppList) {
            opp.StageName = 'Closed Lost';
        }

        if(!oppList.isEmpty()) {
            update oppList;
        }

        System.debug('Updated Opportunities: ' + oppList.size());
    }
}