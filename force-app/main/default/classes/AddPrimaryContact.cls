public class AddPrimaryContact implements Queueable{
    public contact con;
    public string stateStr;
    public AddPrimaryContact(contact con, string stateAbr){
        this.con = con;
        this.stateStr = stateAbr;
    }
    
    public void execute(QueueableContext context){
        List<Contact> conList = new List<Contact>();
        for(Account acc: [select id, name, BillingState  from Account where BillingState =: stateStr limit 200]){
            contact cont = con.clone(false,false,false,false);
            cont.AccountId = acc.id;
            conList.add(cont);
        }
        if(conList.Size() > 0){
            insert conList;
        }
    }
}