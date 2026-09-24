@isTest
public class testSchedular {

    @isTest
    static void testSch() {

        Test.startTest();

        String cron = '0 0 0 1 1 ? 2099';

        String jobId = System.schedule(
            'Test Batch Job',
            cron,
            new AccountBatchScheduler()
        );

        Test.stopTest();

        CronTrigger ct = [
            SELECT Id, CronExpression, TimesTriggered
            FROM CronTrigger
            WHERE Id = :jobId
        ];

        System.assertEquals(cron, ct.CronExpression);
    }
}