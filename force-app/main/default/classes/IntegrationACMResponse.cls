public class IntegrationACMResponse {
/*Test Response data 
//ACMConsignmentService.getConsignmentList();
   "status":"Success",
   "code":"200",
   "message":"testMessage",
   "consignment":[    
         {
            "Consignment_NUMBER":"1",
            "Consignment_STATUS":"ACTIVE"
         },
         {
            "Consignment_NUMBER":"2",
            "Consignment_STATUS":"ACTIVE"
         }      
   ]   
}     
*/
 public class ACMListConsignmentsResponse extends IntegrationACMResponseAbstract{
   public ConsignmentsResponse listConsignmentsResponse {get;set;}  
 }
 Public class ConsignmentsResponse {
      public ConsignmentsOutput listConsignmentsOutput {get;set;}
 }  
 public class ConsignmentsOutput {
 public List<ConsignmentData> consignment {get;set;}
 }
  
  public class ConsignmentData{
  public string consignmentNumber { get; set ;}
  public string alternateConsignmentNumber { get; set ;}
  public string customerReferenceNumber { get; set ;} 
 }  
 public class ACMRetrieveConsignmentResponse extends IntegrationACMResponseAbstract{
  Public RetrieveConsignmentOutput retrieveConsignmentOutput;   
 }
 
 public class RetrieveConsignmentOutput{
 public string consignmentFoundFlag { get; set ;}
 public string consignmentNumber { get; set ;}
 }
 
 public class animalsData{
 
 public List<string> animals;
 
 }
}