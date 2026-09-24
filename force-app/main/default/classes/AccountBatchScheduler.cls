global class AccountBatchScheduler implements Schedulable {

    global void execute(SchedulableContext sc){

        AccountBatch batch = new AccountBatch();

        Database.executeBatch(batch, 200);
    }
}