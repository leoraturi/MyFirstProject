/******************************************************************************************************
* Name:    ECDCUpdateContact_BatchSchedule 
* Author:  
* Purpose: schedule class for Contact Update in every 5 mins
*=====================================================================================================*
* History                                                                                             *
* -------                                                                                             *
* VERSION  AUTHOR                  DATE              DETAIL                           RELEASE/CSR     * 
*           Rahul             
*******************************************************************************************************/
global class ECDCUpdateContact_BatchSchedule implements Schedulable { 

    public static String sched1 = '0 5 * * * ?';   
    public static String sched2 = '0 10 * * * ?'; 
    public static String sched3 = '0 15 * * * ?'; 
    public static String sched4 = '0 20 * * * ?'; 
    public static String sched5 = '0 25 * * * ?'; 
    public static String sched6 = '0 30 * * * ?'; 
    public static String sched7 = '0 35 * * * ?'; 
    public static String sched8 = '0 40 * * * ?';
    public static String sched9 = '0 45 * * * ?';
    public static String sched10 = '0 50 * * * ?';
    public static String sched11 = '0 55 * * * ?';
    public static String sched12 = '0 00 * * * ?';   
 
  public interface ISchedule {
    void execute(SchedulableContext sc);
  }
  global void execute(SchedulableContext sc) {
        Type targetType = Type.forName('ECDCUpdateContact_Batch');
        if(targetType != null) {
            ISchedule batch = (ISchedule)targetType.newInstance();
            batch.execute(sc);
        }
  }
  //Schedule Time Interval Class
  global static void scheduleMe() {
        ECDCUpdateContact_BatchSchedule  SC = new ECDCUpdateContact_BatchSchedule (); 
        System.schedule('ECDCUpdateContactBatchProcess1', sched1, SC);
        System.schedule('ECDCUpdateContactBatchProcess2', sched2, SC);
        System.schedule('ECDCUpdateContactBatchProcess3', sched3, SC);
        System.schedule('ECDCUpdateContactBatchProcess4', sched4, SC);
        System.schedule('ECDCUpdateContactBatchProcess5', sched5, SC);
        System.schedule('ECDCUpdateContactBatchProcess6', sched6, SC);
        System.schedule('ECDCUpdateContactBatchProcess7', sched7, SC);
        System.schedule('ECDCUpdateContactBatchProcess8', sched8, SC);
        System.schedule('ECDCUpdateContactBatchProcess9', sched9, SC);
        System.schedule('ECDCUpdateContactBatchProcess10', sched10, SC);
        System.schedule('ECDCUpdateContactBatchProcess11', sched11, SC);
        System.schedule('ECDCUpdateContactBatchProcess12', sched12, SC);
  }
}