public class DemoAppexClass {

    
    public static void databaseDemo(){
        
        List<Contact> lc = new List<Contact>{ new Contact(FirstName ='demodB1', LastName ='poonia' , Department = 'B.tech'), new Contact(FirstName ='demodB2', LastName ='poonia' , Department = 'B.CA'), new Contact()};
          Database.SaveResult[] dr =Database.insert(lc,false);
                                                                                                                                         
     for( Database.Saveresult sr : dr){
         if(sr.isSuccess()){
             System.debug('cintact is inserted='+sr.getId());
         }else{
             for(Database.Error er:sr.getErrors()){
                 
                 System.debug(er.getStatusCode()+'this is for exception'+er.getMessage());
                 System.debug('this is field for data='+er.getFields());
                 
                 
                 
                 
             }
         }
           
     }                                                                                                                               
                                                                                                                                         
           
                                                                                                                                         
                                                                                                                                         
                                      
                                                                                                                                         
        
        
        
        
        
    }
    
    
    
    
    
    
    
}