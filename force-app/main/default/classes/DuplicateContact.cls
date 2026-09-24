public class DuplicateContact{
    
    public static void duplicateCon(List<Contact> newCon){
        
        Set<String> emails = new Set<String>();
        
              for(Contact con:newCon){
                if(con.Email != null){
                emails.add(con.Email);
              }
            }
            
           
        
        if(emails.isEmpty()){
            return;
        }
        
       // Map<String , Contact> mc = new Map<String , Contact>();
        
     List<Contact> lc =[SELECT Id,Salutation, FirstName,LastName, Email FROM Contact WHERE Email IN :emails];

        
       // for(Contact cn : lc){
          //  if(!mc.containsKey(cn.Email)){
            //  mc.put(cn.Email ,cn);
            //}
       // }
        
   List<Contact> lc1 = new List<Contact>();// Contact to update. 
        
      for(Contact cn :newCon){
            
            for(Contact co :lc){

            if( co != null && co.Id != cn.Id && co.FirstName == cn.FirstName && co.LastName == cn.LastName && co.Salutation == cn.Salutation && 
                 co.Email.toLowerCase() == cn.Email.toLowerCase()){
                  lc1.add(new Contact(Id = cn.Id,Is_Duplicate__c = true,Oiginal_Contact__c = co.Id ,Duplicate_Detected_On__c = system.now()));
                     break;
                               
            } 
            
            }
            
           Contact c = [SELECT Id, Name, CreatedById FROM Contact WHERE Id = :cn.Id];
        
          Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

          mail.setTargetObjectId(c.CreatedById);
            
         mail.setSaveAsActivity(false);

         mail.setSubject('Duplicate Contact Created');

         mail.setPlainTextBody('The Contact "' + c.Name +'" is a duplicate.' );

         Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            
            
    }
       
        if(!lc1.isEmpty()){
            update lc1;
            }
        
        
         }
}