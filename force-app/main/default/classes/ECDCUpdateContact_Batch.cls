/***********************************************************************************************************************
* Name:    ECDCUpdateContact_Batch
* Author:  Rahul Raturi
* Purpose: Class used to send contact update to ECDC
*======================================================================================================================*
* History                                                                                                              *
* -------                                                                                                              *
* VERSION  AUTHOR           DATE              DETAIL                                               RELEASE/CSR         *
*   1.0 -  Rahul Raturi     29/01/2019        INITIAL DEVELOPMENT                                   
              
                     *
************************************************************************************************************************/
/*
Ad-hoc usage:
Database.executeBatch(new ECDCUpdateContact_Batch(), 10);

Governor Limits:
https://help.salesforce.com/apex/HTViewSolution?id=000176644&language=en_US
*/
global class ECDCUpdateContact_Batch implements Database.Batchable<sObject>,Database.AllowsCallouts,ECDCUpdateContact_BatchSchedule.ISchedule  {

public static final String ECDC_UPDATE_CONTACT_BATCH = 'ECDCUpdateContact_Batch';
Datetime lastSuccessfulRun;
global Database.QueryLocator start(Database.BatchableContext BC) {
   
      return Database.getQueryLocator([SELECT id 
                                       FROM Contact limit 100]);       

}

global void execute(Database.BatchableContext BC, List<sObject> scope) {


}

global void finish(Database.BatchableContext BC) {}
/**********************************************************
        From ISchedule interface
        
        Method executed when scheduled with ECDCUpdateContact_BatchSchedule apex class
**********************************************************/
public void execute(SchedulableContext SC) {
        
        //do not run batch if there is already one prepared for execution
        List<AsyncApexJob> runningJobs = [SELECT Id 
                                          FROM AsyncApexJob 
                                          WHERE JobType = 'BatchApex' 
                                          AND (Status = 'Processing' OR Status = 'Queued' OR Status = 'Preparing')
                                          AND ApexClass.Name = : ECDC_UPDATE_CONTACT_BATCH];
                                          
        if(runningJobs.IsEmpty()) {
            Integer BatchLimit = 10;                        
            Database.executeBatch(this, BatchLimit); 
        }
    }
}