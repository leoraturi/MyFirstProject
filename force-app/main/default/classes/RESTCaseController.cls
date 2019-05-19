@RestResource(urlMapping='/CaseRecords/*')
global class RESTCaseController {
  @HttpGet
  global static List<case>getCase() {
  List<case> lst =[Select id,casenumber from case limit 5];
  return lst;
  }
}