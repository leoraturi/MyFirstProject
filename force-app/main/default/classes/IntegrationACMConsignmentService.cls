public class IntegrationACMConsignmentService {
 public static BaseService baseRef { get; set; }
 @testVisible private static final String GET_CONSignment = 'GetConSignmentLsit';
 @testVisible private static final String GET_CONSignment_URL = 'GET_CONSignment_RestService_URL';
 @testVisible private static final String Get_Default_OrgID = 'Get_Default_OrgID ';
 @testVisible private static final String Get_ServiceType = 'GET';
 @testVisible private static final String POST_ServiceType = 'POST';
 public static Map<String, Object> requestQueryParams;
 public static string requestBody = '';
 public static string responseBody = '';
 class BaseService {
        public string ServiceName {get;set;}           
        public string ServiceURLValue { get; set; }       
        public string OrgId { get; set;}
        public string RequestType {get; set;}
        public BaseService() {
        }
        public BaseService(String serviceName,string serviceURLValue,String orgId,string requestType) {
           this.ServiceName = serviceName;
          // this.ServiceURLValue = this.serviceURLValue;
           this.ServiceURLValue = 'http://demo1819137.mockable.io/GetConSignmentLsit';
           this.OrgId = orgId;
           this.RequestType = requestType;  
       }
    }
  public static void initializeBaseService(String serviceName, String serviceURLValue,string orgId,string requestType  ) {
    baseRef = new BaseService(serviceName,serviceURLValue,orgId,requestType);
  }
  public static map<String, String> ACMConsignmentListReq = new map<String, String>();
  //public static ACMResponse.ACMListConsignmentResponse getConsignmentList(){
  public static void getConsignmentList(){
       IntegrationACMResponse.ACMListConsignmentResponse objListConsignmentResponse = new IntegrationACMResponse.ACMListConsignmentResponse();
       initializeBaseService(GET_CONSignment, GET_CONSignment_URL , Get_Default_OrgID,Get_ServiceType);
       ACMConsignmentListReq.put('param1','param1value');
       ACMConsignmentListReq.put('param2','param2value');
       requestBody  = JSON.serializePretty(ACMConsignmentListReq);
       system.debug('reqBody>>>>'+requestBody );
       responseBody =  getResponse(Get_ServiceType, ACMConsignmentListReq);
       system.debug('responseBody>>>>'+responseBody);
       objListConsignmentResponse=(IntegrationACMResponse.ACMListConsignmentResponse)JSON.deserialize(responseBody , IntegrationACMResponse.ACMListConsignmentResponse.class);
       system.debug('objListConsignmentResponse.error>>>>>'+objListConsignmentResponse.error);
              system.debug('objListConsignmentResponse.status>>>>>'+objListConsignmentResponse.status);
                     system.debug('objListConsignmentResponse.code>>>>>'+objListConsignmentResponse.code);
                            system.debug('objListConsignmentResponse.message>>>>>'+objListConsignmentResponse.message);
                                   system.debug('objListConsignmentResponse.lstConsignment>>>>>'+objListConsignmentResponse.lstConsignment );
     //  return objListConsignmentResponse ;  
  }
  private static string getResponse(string serviceType,map<string,string> mapHeaderParams ) {
   IntegrationResponseWrapper r;
   requestQueryParams = mapHeaderParams ;
   if(serviceType.equalsIgnoreCase('GET')) {
       for(String key: requestQueryParams.keySet()) {
                        if(null != requestQueryParams.get(key) && '' != requestQueryParams.get(key)) {
                            baseRef.serviceURLValue += baseRef.serviceURLValue.endsWith('&') ? 
                                key+'='+EncodingUtil.urlEncode(String.ValueOf(requestQueryParams.get(key)),'UTF-8')+'&': 
                            '?'+key+'='+EncodingUtil.urlEncode(String.ValueOf(requestQueryParams.get(key)),'UTF-8')+'&';
                        }
        }
   }
    if(baseRef.serviceURLValue.endsWith('&')) {
                    baseRef.serviceURLValue= baseRef.serviceURLValue.substring(0, baseRef.serviceURLValue.length() -1);
                }
   system.debug('<<<<<<<<<<'+ serviceType+' '+baseRef.ServiceName+' '+baseRef.ServiceURLValue+' '+requestBody+ ' '+mapHeaderParams);
   r = doCalloutWithoutAPITransaction(serviceType,baseRef.ServiceName ,baseRef.ServiceURLValue ,requestBody,'testServiceToken','application/json',true,mapHeaderParams);
   system.debug('response>>>>'+r.response.getBody());
   return r.response.getBody();
  }  
   private static IntegrationResponseWrapper doCalloutWithoutAPITransaction(String strRequestType,
                                                                  String strServiceName,
                                                                  String strServiceURL,
                                                                  String strRequestBody,
                                                                  String strAccessToken,
                                                                  String strContentTypeHeader,
                                                                  Boolean bisTimeoutEnforced,
                                                                  Map<String, String> mapHeaderParams) {
                                                                      IntegrationResponseWrapper responseWrapperObj;
                                                                  if(strRequestType.equalsIgnoreCase('GET')){
                                                                          responseWrapperObj = IntegrationACM_Callout.doGETWithoutAPITransaction(strServiceName,
                                                                                                                                      strServiceURL,
                                                                                                                                      'Bearer '+ strAccessToken,
                                                                                                                                      strContentTypeHeader,
                                                                                                                                      bisTimeoutEnforced,                                                                                                                                      
                                                                                                                                      mapHeaderParams);
                                                                      }
                                                                      
                                                                      return responseWrapperObj;
                                                                      
                                                                  }
}