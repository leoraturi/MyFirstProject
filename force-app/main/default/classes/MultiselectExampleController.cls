public  class MultiselectExampleController {

    public PageReference Cancle() {
        PageReference pageRef = new PageReference('/apex/testaccount');
        pageRef.setRedirect(true);
        return pageRef;
    }


    public SelectOption[] selectedContacts { get; set; }
    public SelectOption[] allContacts { get; set; }
    
    public String message { get; set; }

        public String BusNo{ get; set; }    
    public MultiselectExampleController() {
        selectedContacts = new List<SelectOption>();
        
        List<Lines__C> contacts = [SELECT Name, Id FROM Lines__C order by Name];    
        allContacts = new List<SelectOption>();
        for ( Lines__C c : contacts ) {
            allContacts.add(new SelectOption(c.Id, c.Name));
        }
    }

    public PageReference save() {
    
      Bus__c objbus =new Bus__c ();
      objbus.BUS_CRN__c=BusNo;
     // Boolean first = true;
      /*
        message = 'Selected Contacts: ';
        Boolean first = true;
        for ( SelectOption so : selectedContacts ) {
            if (!first) {
                message += ', ';
            }
            message += so.getLabel() + ' (' + so.getValue() + ')';
            first = false;
        }
        
        return null;       
     */
       system.debug('selectedContacts>>>>>'+selectedContacts);
       string lines='';
       for(SelectOption so : selectedContacts){
       
        lines= lines+so.getLabel() +',';
        
        system.debug('testing>>>>>'+so.getLabel());
        
        
          //  first = false;    
       }
       
       lines=lines.removeend(',');
       objbus.Lines__c=lines;
       system.debug('testing>>>>>'+objbus.Lines__c);
       Insert objbus ;
       
      
        PageReference pageRef = new PageReference('/apex/testaccount');
        pageRef.setRedirect(true);
        return pageRef;        
        
    }
}