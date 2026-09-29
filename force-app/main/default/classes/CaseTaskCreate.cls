public class CaseTaskCreate implements Queueable {
      
    public List<Case> lc;
    
    public CaseTaskCreate(List<Case> qc){
        lc = qc; 
    }
    
    public  void execute(QueueableContext qc){
          List<Task> l = new  List<Task>();
        //create Task 
        for(Case c:lc){
          Task newT = new Task();
            newT.Subject = 'Follow Up';
            NewT.ActivityDate = System.Today()+30;
            newT.WhatId = c.Id;
            l.add(newT);
        }
       
        if(!l.isEmpty()){
            insert l;
        } 
    }
    
}