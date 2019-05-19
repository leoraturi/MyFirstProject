public class IntegrationACM_CalloutNew{
public static IntegrationResponseWrapper doGETApiTransaction(String serviceName,
                                       String serviceURL,                                       
                                       String contentType,                                                                  
                                       map<String,String> headersMap){     
        HttpRequest r = getHttpRequest(serviceName, 'GET', contentType, serviceURL, null, headersMap);
        system.debug('HttpRequest >>>>'+r);
        IntegrationResponseWrapper responseReceived = getResponse(r);
        system.debug('responseReceived >>>>>>'+responseReceived );
        return responseReceived ;
    }
public static IntegrationResponseWrapper doPOSTWithOutAPITransaction(String serviceName,
                                        String serviceURL,
                                        String requestBody,                                  
                                        String contentType,                                                                                
                                        map<String,String> headersMap){ 
       
        HttpRequest r = getHttpRequest(serviceName, 'POST',contentType, serviceURL, requestBody, headersMap);
        IntegrationResponseWrapper responseReceived = getResponse(r);
        //prepareApiTransaction('Post','Insert',requestInTime,service,JSON.serialize(requestMap),responseReceived,destinationSystem);
        return responseReceived ;
 }    
     private static HTTPRequest getHttpRequest(String serviceName,
                                              String methodType,                                              
                                              String contentType,
                                              String serviceURL,
                                              String requestBody,                                              
                                              map<String,String> headersMap){    
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(serviceURL);
        req.setMethod(methodType);
        if (contentType != null && contentType != ''){
            req.setHeader('Content-Type', contentType); 
        }
        /*           
        if (authorisationHeader != null)
            req.setHeader('Authorization', authorisationHeader); 
        */       
        if (headersMap != null && headersMap.size() > 0 ){
            for(String s :headersMap.keyset()){
                req.setHeader(s, headersMap.get(s));   
            }
        }
        if (requestBody != null)
            req.Setbody(requestBody);
            req.setTimeOut(20000);
        
        return req;
    }
    private static IntegrationResponseWrapper getResponse(HttpRequest r){
       
           datetime inTimeentry = system.now(); 
          try {
            Http h = new Http();
            HttpResponse responseback = h.send(r);
            decimal e =  system.now().gettime() - intimeentry.gettime();
           return new IntegrationResponseWrapper(false,null,responseback);            
        }
        //we might get exception if url is corrupted or for bad request.
        catch(Exception e) {
            decimal ee =  system.now().gettime() - intimeentry.gettime();
            return new IntegrationResponseWrapper(e,null);
        } 
    }
    }