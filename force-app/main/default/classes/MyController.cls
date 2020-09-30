public class MyController {

    public String Save { get; set; }
   public account account{get; set;}
   public string error{get; set;}
   public string selectedItems{get;set;}
   public string selectedItems2{get;set;}
   public boolean inputText{get; set;}
   public string value;
   List<Account> accounts;
   
   public void hideInputText(){
       inputText = false;
   }

    public List<Account> getAccounts() {
        if(accounts == null)
            accounts = [SELECT name, owner.name FROM account LIMIT 10];
        return accounts;
    }

   public MyController(){
       account = new account();
       inputText = true;
       value ='';
   }
   public void save(){
       try{
           //insert account;
           system.debug('selectedItems : '+selectedItems);
           system.debug('selectedItems2 : '+selectedItems2);
           value = apexPages.currentPage().getParameters().get('selected');
           string passedParam2 = system.CurrentPageReference().getParameters().get('selected'); 
           system.debug('value : '+value+'*** passedParam2 : '+passedParam2);
       }
       catch(exception ex){
           //ApexPages.addMessages(ex);
           System.debug('error : '+ex.getMessage());
           //ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.Error, ex.getMessage());
            //ApexPages.addMessage(msg);
            error = ex.getMessage();
            
       }
   }
   public static List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>();
        
        options.add(new SelectOption('US','US'));
        options.add(new SelectOption('CANADA','Canada'));
        options.add(new SelectOption('MEXICO','Mexico'));

        return options;
    }
    
    public static List<SelectOption> getItems2() {
        List<SelectOption> options = new List<SelectOption>();
        
        options.add(new SelectOption('US','US'));
        options.add(new SelectOption('CANADA','Canada'));
        options.add(new SelectOption('MEXICO','Mexico'));

        return options;
    }
}