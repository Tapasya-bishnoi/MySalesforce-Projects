public class CaseTransferFile {

  public static void checkCase(List<Case> caseList){
        
            List<Case> lc = new List<Case>();
        for(Case rc : caseList){
            if(rc.status == 'Escalated'){
                lc.add(rc);
            }
        }
      
      if(!lc.isEmpty()){
          
          System.enqueueJob(new  CaseTaskCreate(lc));
      }
      
}
}