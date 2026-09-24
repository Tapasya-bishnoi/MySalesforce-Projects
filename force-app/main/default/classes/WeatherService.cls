public class WeatherService{

    @future(callout=true)
    public static void getWeather(Set<Id> leadIds){
             System.debug('Future method started');
        
        List<Lead> leads =[SELECT Id, Country, Temperature__c FROM Lead WHERE Id IN :leadIds];

        List<Lead> updateLeads = new List<Lead>();

        for(Lead ld : leads){
            
            System.debug('Country: ' + ld.Country);

            try{
                 Http http = new Http();
                HttpRequest req = new HttpRequest();

                String endpoint = 'https://wttr.in/' +EncodingUtil.urlEncode(ld.Country,'UTF-8')+'?format=j1';
                  req.setEndpoint(endpoint);  
                   req.setMethod('GET');
                
                   System.debug('Endpoint: ' + endpoint);
                
                   HttpResponse res = http.send(req);     
                        
                  if(res.getStatusCode() == 200){   
                    Map<String,Object> result = (Map<String,Object>)JSON.deserializeUntyped(res.getBody());
                    List<Object> current =(List<Object>)result.get('current_condition');
                      
                      System.debug('Status Code: ' + res.getStatusCode());
                      System.debug('Response Body: ' + res.getBody());
                   if(current != null &&!current.isEmpty()){
                       
                    Map<String,Object> weather =(Map<String,Object>)current[0];
                
                          String temp =(String)weather.get('temp_C');
               
                      ld.Temperature__c =Decimal.valueOf(temp);
                      updateLeads.add(ld);
                     
               }
          }

            }catch(Exception e){
                System.debug('Weather API Error : ' +e.getMessage());
            }
        }

        if(!updateLeads.isEmpty()){
            update updateLeads;
        }
    }
}