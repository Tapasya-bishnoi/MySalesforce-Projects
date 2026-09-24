public class StringListTest{
    
    
    public static List<String> generateStringList(Integer i){
        List<String> ls = new List<String>();
        for(Integer j =0; j<i ; j++){
            String a = 'Test ' + j;
         ls.add(a);
        }
        
      return ls;  
        
    }
    
    
    
    
    
    
    

}