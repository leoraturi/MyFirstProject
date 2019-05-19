public class IntegrationACM_Callout{
public static IntegrationResponseWrapper doGETWithoutAPITransaction(String service,
                                       String URL,
                                       String authorisationHeader,
                                       String contentType,
                                       boolean isTimeOutEnforced,                            
                                       map<String,String> headersMap){
        dateTime requestInTime = system.now();
        HttpRequest r = getHttpRequest(service, 'GET', authorisationHeader, contentType, url, null, isTimeOutEnforced, headersMap);
        system.debug('HttpRequest >>>>'+r);
        IntegrationResponseWrapper responseReceived = getResponse(r);
        system.debug('responseReceived >>>>>>'+responseReceived );
        return responseReceived ;
    }
     private static HTTPRequest getHttpRequest(String service,
                                              String methodType,
                                              String authorisationHeader,
                                              String contentType,
                                              String URL,
                                              String requestBody,
                                              boolean isTimeOutEnforced,
                                              map<String,String> headersMap){    
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod(methodType);
        if (contentType != null && contentType != ''){
            req.setHeader('Content-Type', contentType); 
        }           
        if (authorisationHeader != null)
            req.setHeader('Authorization', authorisationHeader); 
               
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