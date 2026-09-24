@isTest
private class AccountBatchTest {

    @isTest
    static void testBatch() {

        List<Account> accs = new List<Account>();

        for(Integer i=0; i<10; i++){
            accs.add(new Account(Name='Test'+i));
        }

        insert accs;

        Test.startTest();
        Database.executeBatch(new AccountBatch(), 200);
        Test.stopTest();

        List<Account> updatedAccs =
            [SELECT Id, Description FROM Account WHERE Name LIKE 'Test%'];

        System.debug(updatedAccs);

        for(Account acc : updatedAccs){
            System.assertEquals('Updated by Batch Job', acc.Description);
        }
    }
}