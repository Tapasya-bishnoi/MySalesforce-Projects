public class AccRec {
    
    public static void creatingaccoppcon(){
        
      Account ac = new Account();
        ac.Name ='Mr Vedprakash';
        ac.Phone = '90231243342';
         insert ac;
        
        Contact con = new Contact();
         con.Email = 'pooniatapasya023449@gmail.com';
         con.Phone = '9809700098';
         con.LastName = 'gadhriya';
         con.AccountId = ac.Id;
           insert con;
        
        Opportunity op = new Opportunity();
         op.Name = 'Software Developer';
          op.CloseDate= Date.today().addDays(30);
           op.StageName = 'Prospecting';
          op.AccountId = ac.Id;
          insert op ;
         
       }
    
    

}