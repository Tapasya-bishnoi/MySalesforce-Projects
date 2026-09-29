public class SecondJob implements Queueable{
    
    public void execute(QueueableContext context) {

        System.debug('Second Job is running');

        // Chain Third Job
        System.enqueueJob(new ThirdJob());
    }  
    
    
}