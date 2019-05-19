public class TestAccount {
public id accountID{get;set;}

Public Map<string,Integer> TotalLineItems {get;set;}
public List<IteratorClass> lstIteratorClass{get;set;}
public TestAccount ()
{
accountID=[SELECT AccountId FROM User 
           where id=:Userinfo.getUserId()].AccountId ;
GetTotalLineItems();
}

Public static void UpdateAccountOnBus(List<Bus__c> listBus){
  
  id accountID=[SELECT AccountId 
             FROM User 
             where id=:Userinfo.getUserId()].AccountId ;
  system.debug('accountIDaccountID>>>>'+accountID);           
  for( Bus__c objBus : listBus){
      objBus.Account__c=accountID;
  }
}

Public static void UpdateAccountOnBus1(List<Bus__c> listBus){
  
  id accountID=[SELECT AccountId 
             FROM User 
             where id=:Userinfo.getUserId()].AccountId ;
             
  List<Account> lstAccount=[SELECT id,TotalBusRegistered__c
             FROM Account 
             where id=:AccountId] ;
             if(lstAccount[0].TotalBusRegistered__c!=null)
  lstAccount[0].TotalBusRegistered__c=lstAccount[0].TotalBusRegistered__c+1; 
  else{lstAccount[0].TotalBusRegistered__c=1;}                    
           
  update lstAccount;
}


public void GetTotalLineItems(){

 TotalLineItems =new Map<string,Integer>();
 List<bus__c> lstBus=new List<Bus__c>();
 id accountID=[SELECT AccountId 
             FROM User 
             where id=:Userinfo.getUserId()].AccountId ;
 
 lstBus=[SELECT Account__c,BUS_CRN__c,Lines__c 
         FROM Bus__c 
         where Account__c=:accountID];
 
 for(bus__c objbus :lstBus){
  if(!string.isblank(objbus.Lines__c)){
  for(string s : objbus.Lines__c.split(',') ){
   
   if(!string.Isblank(String.valueof(TotalLineItems.get(s))))
   {
    TotalLineItems.put(s,Integer.ValueOf(TotalLineItems.get(s))+1);
   }
   else{
   TotalLineItems.put(s,1);
   }
  
  }
 }
 }
 lstIteratorClass=new List<IteratorClass>();
 
 for(string s :TotalLineItems.keyset()){
  
  IteratorClass objIteratorClass=new IteratorClass();
  objIteratorClass.LineNumber=s;
  objIteratorClass.Count=TotalLineItems.get(s);
  lstIteratorClass.add(objIteratorClass); 
 }
 
 // system.debug('TotalLineItems>>>'+TotalLineItems);
}


public class IteratorClass {
public string LineNumber{get;set;}
public Integer Count{get;set;}

}

}