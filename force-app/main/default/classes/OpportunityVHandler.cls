public class OpportunityVHandler{
     @future
    public static void markVIPDeals(List<Id> oppIds){

        List<Opportunity> oppsToUpdate = new List<Opportunity>();

        for(Opportunity opp : [
            SELECT Id, VIP_Deal_c__c
            FROM Opportunity
            WHERE Id IN :oppIds
        ]) {

            opp.VIP_Deal_c__c = true;
            oppsToUpdate.add(opp);
        }

        if(!oppsToUpdate.isEmpty()){
            update oppsToUpdate;
        }
    
}
    
}