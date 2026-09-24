@isTest
public class AccountBatchSchedulerTest {

    @isTest
    static void testScheduler() {

        List<Account> accs = new List<Account>();

        for(Integer i = 0; i <10; i++) {
            accs.add(new Account(Name='Test tapasya' +i));
        }

        insert accs;
        
        System.debug('Accounts with null description: ' +[SELECT Count() FROM Account]);

     Test.startTest();

       String cron = '0 36 12 * * ?';

        System.schedule('Test Batch Job',cron,new AccountBatchScheduler());

        Test.stopTest();
           List<Account> accList = [SELECT Id, Name, Description FROM Account WHERE Name LIKE 'Test%'];

            System.debug(accList);
          System.assertEquals(10, accList.size());
     
  }
}