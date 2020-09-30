Public class utilityClass{
    public static List<Account> createAccounts(integer intNumber){
        List<Account> accList = new List<Account>();
        for(integer i =0; i<= intNumber; i++){
            
            Account acc = new Account();
            acc.name = 'Test '+i;
            acc.Industry = 'Agriculture';
            acc.site = 'site';
            accList.add(acc);
            
        }
        return accList;
    }
    
    public static Account createAccount(){
        Account acc = new Account();
            acc.name = 'Test';
            acc.Industry = 'Agriculture';
            acc.site = 'site';
        return acc;
    }
}