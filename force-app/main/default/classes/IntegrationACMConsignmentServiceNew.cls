public class IntegrationACMConsignmentServiceNew {
@testVisible private static final String GET_ServiceType = 'GET';
@testVisible private static final String POST_ServiceType = 'POST';
@testVisible private static final String Service_GET_CONSignment = 'GetConSignmentList';
public static BaseService baseRef { get; set; }
private static final string ORG_ID = 'abcd';
public static string requestBody = '';
public static string responseBody = '';
public static Map<String, Object> requestQueryParams;
class BaseService {
    public string serviceName {get;set;}           
    public string serviceURL { get; set; }       
    public string orgId { get; set;}
    public string requestType {get; set;}
    public BaseService() {
    }
    public BaseService(String serviceName,string serviceURLValue,String orgId,string requestType) {
       this.ServiceName = serviceName;
      // this.ServiceURLValue = this.serviceURLValue;
      // this.serviceURL = 'http://demo1819137.mockable.io/ConsignmentDetails?Query=consignmentNumber=\'Test\'' ;
                 //           http://demo1819137.mockable.io/ConsignmentDetails?Query=consignmentNumber=Test
    //  this.serviceURL = 'http://demo1819137.mockable.io/ConsignmentDetails?Query=' ;
       this.serviceURL = serviceURLValue ;
       this.OrgId = orgId;
       this.requestType = requestType;  
    }
}

public static void getConsignmentDetails(Map<String, String> requestParams){
   IntegrationACMResponse.ACMRetrieveConsignmentResponse objListConsignmentResponse = new IntegrationACMResponse.ACMRetrieveConsignmentResponse();
   baseRef = new BaseService(Service_GET_CONSignment,'http://demo1819137.mockable.io/ConsignmentDetails?Query=',ORG_ID ,GET_ServiceType);
   requestQueryParams = (map<string, object>)requestParams;
   map<string,string> mapHeaderParams = new map<string,string>();
   mapHeaderParams.put('Api-Subscription-Key','Api-Subscription-Key');
   responseBody =  getResponse(baseRef.requestType, mapHeaderParams);
   system.debug('responseBody>>>'+responseBody);
   objListConsignmentResponse = (IntegrationACMResponse.ACMRetrieveConsignmentResponse)JSON.deserialize(responseBody , IntegrationACMResponse.ACMRetrieveConsignmentResponse.class);
   
   system.debug('objListConsignmentResponse >>>'+objListConsignmentResponse);
}

public static void getConsignmentList(){
   IntegrationACMResponse.ACMListConsignmentsResponse objListConsignmentResponse = new IntegrationACMResponse.ACMListConsignmentsResponse();
   baseRef = new BaseService(Service_GET_CONSignment,'http://demo1819137.mockable.io/GetConSignmentLsit',ORG_ID ,POST_ServiceType);
   map<String, String> acmRestReq = new map<String, String>();
   acmRestReq.put('param1','param1value');
   acmRestReq.put('param2','param2value');  
   requestBody  = JSON.serializePretty(acmRestReq);   
   map<string,string> mapHeaderParams = new map<string,string>();
   mapHeaderParams.put('Api-Subscription-Key','Api-Subscription-Key');
   responseBody =  getResponse(baseRef.requestType, mapHeaderParams);
   system.debug('responseBody>>>'+responseBody);
   objListConsignmentResponse = (IntegrationACMResponse.ACMListConsignmentsResponse)JSON.deserialize(responseBody , IntegrationACMResponse.ACMListConsignmentsResponse.class);
   system.debug('objListConsignmentResponse >>>'+objListConsignmentResponse);
   system.debug('objListConsignmentResponse >>>'+objListConsignmentResponse.listConsignmentsResponse.listConsignmentsOutput.consignment);
  // system.debug('objListConsignmentResponse >>>'+objListConsignmentResponse.listConsignmentsOutput.listConsignmentsOutput);
  // system.debug('responseBody>>>'+responseBody);
}


 private static string getResponse(string requestType,map<string,string> mapHeaderParams ) {
  IntegrationResponseWrapper responseWrapperObj; 
 // requestQueryParams = '';
 
  if(requestType.equalsIgnoreCase('GET')) {
       for(String key: requestQueryParams.keySet()) {
            if(null != requestQueryParams.get(key) && '' != requestQueryParams.get(key)) {
               // baseRef.serviceURL+= baseRef.serviceURL.endsWith('&') ? 
                 baseRef.serviceURL+=   key+'=\''+EncodingUtil.urlEncode(String.ValueOf(requestQueryParams.get(key)),'UTF-8')+'\'&'; 
                    //key+'='+EncodingUtil.urlEncode(String.ValueOf(requestQueryParams.get(key)),'UTF-8')+'&';
            }
        }
   }
   if(baseRef.serviceURL.endsWith('&')) {
       baseRef.serviceURL = baseRef.serviceURL.substring(0, baseRef.serviceURL.length() -1);
   }
  
   system.debug('baseRef.serviceURL>>>>>'+baseRef.serviceURL);
    responseWrapperObj= doCalloutAPITransaction(baseRef.requestType,baseRef.ServiceName ,baseRef.serviceURL,requestBody,'application/json',mapHeaderParams);
   //system.debug('response>>>>'+r.response.getBody());
   return responseWrapperObj.response.getBody();
 }
 
 private static IntegrationResponseWrapper doCalloutAPITransaction(String requestType,
                                                                  String serviceName,
                                                                  String serviceURL,
                                                                  String requestBody,                                                                  
                                                                  String contentTypeHeader,                                                                  
                                                                  Map<String, String> mapHeaderParams) {
                                                                      IntegrationResponseWrapper responseWrapperObj;
                                                                      
                                                                  if(requestType.equalsIgnoreCase('GET')){
                                                                          responseWrapperObj = IntegrationACM_CalloutNew.doGETApiTransaction(serviceName,
                                                                                                                                      serviceURL,                                                                                                                                      
                                                                                                                                      contentTypeHeader,                                                                                                                                                                                                                                                                           
                                                                                                                                      mapHeaderParams);
                                                                   }
                                                                  else if(requestType.equalsIgnoreCase('POST')) {
                                                                          responseWrapperObj = IntegrationACM_CalloutNew.doPOSTWithOutAPITransaction(serviceName,
                                                                                                                                       serviceURL,
                                                                                                                                       requestBody.trim(),                                                                                                                                       
                                                                                                                                       contentTypeHeader,
                                                                                                                                       mapHeaderParams);
                                                                   }    
                                                                      return responseWrapperObj;                                                                      
                                                                  }
}