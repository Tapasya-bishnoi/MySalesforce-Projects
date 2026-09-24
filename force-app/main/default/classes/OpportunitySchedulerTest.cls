@isTest
public class OpportunitySchedulerTest {

    @isTest
    static void testScheduler() {
        
          Account acc = new Account(Name='Test Account');
               insert acc;

          Opportunity opp = new Opportunity(Name='Test Opp',StageName='Prospecting',CloseDate = System.today().addDays(-5),AccountId=acc.Id);
                insert opp;

        Test.startTest();

        String cronExp = '0 0 1 * * ?';

            System.schedule('Test Opportunity Scheduler',cronExp,new OpportunityScheduler());
        
             Test.stopTest();

            Opportunity updatedOpp = [SELECT Id, StageName FROM Opportunity WHERE Id = :opp.Id];

            System.assertEquals('Closed Lost',updatedOpp.StageName);
        
    }
    
}