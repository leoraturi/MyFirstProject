global class BatchSync implements Database.Batchable<sObject>,Database.Stateful,Database.AllowsCallouts {
 
 public String query = 'Select ID,ECDC_Domain_ID__c,name from Contact limit 10';
 global integer count;
 
 global BatchSync()  {count= 0;
}
 
 global Database.QueryLocator start(Database.BatchableContext BC) {
    return Database.getQueryLocator(query);
 }

 global void execute(Database.BatchableContext BC, List<Contact> records) {             
        String endpoint;
        endpoint = 'https://th-apex-http-callout.herokuapp.com/animals';         
        IntegrationACMResponse.animalsData obj = new IntegrationACMResponse.animalsData();
        
        for ( integer i = 0; i< records.size(); i++ ){
         try {   
          //system.debug('batch size>>>'+records.size()); 
             Http http = new Http();
             HttpRequest request = new HttpRequest();
             request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
             request.setMethod('POST');
             request.setHeader('Content-Type', 'application/json;charset=UTF-8');
             count = count+1;
             system.debug('count >>>'+count );
             string strname = 'mighty moose '+string.valueof(count);            
             String payload = JSON.serialize(
                              new Map<String, Object> {
                              'name' => strname 
                               });
             system.debug(payload );
             request.setBody(payload);
             HttpResponse response = http.send(request);
             
             if (response.getStatusCode() == 201) {
               System.debug('response>>>'+response.getBody());
               obj = (IntegrationACMResponse.animalsData)JSON.deserialize(response.getBody(), IntegrationACMResponse.animalsData.class);
               records[i].ECDC_Domain_ID__c = obj.animals[4];
               system.debug('obj>>>>>'+obj.animals[4]);
             }
            
          }
          catch (Exception e) {         
            System.debug('Error:' + e.getMessage() + 'LN:' + e.getLineNumber() );           
          }
       }
       system.debug('records>>>>>'+records );
       update records ;
    }   

    global void finish(Database.BatchableContext BC){    
    }
}