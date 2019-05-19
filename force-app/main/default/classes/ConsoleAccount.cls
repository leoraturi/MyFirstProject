public class ConsoleAccount {
 private ApexPages.StandardController stdController{get;set;}
 public Account account { get; set; }

    public ConsoleAccount(ApexPages.StandardController controller) {
    stdController=controller;
    this.account = (account )this.stdController.getRecord();

    }
    
    public pagereference redirectpage(){
    stdController.save();
    PageReference page = new Pagereference('/apex/AccountConsole?id='+account.id );
    return page;
    
    }

}