public class testQuableClass implements queueable{
    public List<Account> accList;
    public testQuableClass(List<Account> accounts){
       //accList = [Select Id, name, AnnualRevenue from Account]; 
       this.accList = accounts;
       system.debug('Account List : '+accList.Size());
    }
    public void execute(queueableContext qc){
        for(Account acc: accList){
            if(acc.AnnualRevenue == null){
                acc.AnnualRevenue = 123456789;
            }
        }
        update accList;
    }
}