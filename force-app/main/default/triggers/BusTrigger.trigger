trigger BusTrigger on Bus__c (before Insert, before Update,after insert,after update) {
 if(Trigger.isBefore){
   if(Trigger.isInsert || Trigger.isUpdate){
   TestAccount.UpdateAccountOnBus(trigger.new);
   }
 }
 if(Trigger.isAfter){
   if(Trigger.isInsert || Trigger.isUpdate){
   TestAccount.UpdateAccountOnBus1(trigger.new);
   }
 }
}