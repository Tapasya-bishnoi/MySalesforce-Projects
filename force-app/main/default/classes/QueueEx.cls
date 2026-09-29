public class QueueEx implements Queueable{

    public  void execute(QueueableContext qc){
        
        System.debug('first job is started');
        DataBase.executeBatch(new AccountBatch());
        CallingExm.sum();
        System.enqueueJob(new SecondJob());
     }
    
}