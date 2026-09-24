public class JobPositionTrigger{

    public static void creatTask(List<Job_Position__c> lj){
        
        List<Task> lt = new List<Task>();
        for(Job_Position__c jc : lj){
            Task t = new Task();
            t.Subject = 'Send Quote';
            t.ActivityDate = System.today()+8;
            t.OwnerId = UserInfo.getUserId();
            t.WhatId = jc.Id;
            t.Status = 'In Progress';
            lt.add(t);
           }
        
        if(!lt.isEmpty()){
            insert lt ;
        }
       
        
        
    }
    
    
    
    
    
}