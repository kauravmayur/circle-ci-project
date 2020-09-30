Public class updateAccount{
    
    public static void testAccount1(List<Account> accountList){
        system.debug('@@@ updateAccount 1: '+ accountList);
        for(Account acc: accountList){
            acc.name = 'Test Account 1';
        }
        system.debug('@@@ updateAccount 2: '+ accountList);
        List<Account> accL =[Select id,name from account where id IN: accountList];
        system.debug('@@@ accL : '+ accL);
    }
    
    public static void testAccount2(List<Account> accountList){
        system.debug('@@@ updateAccount 2: '+ accountList);
        for(Account acc: accountList){
            acc.name = 'Test Account 2';
        }
        system.debug('@@@ updateAccount 2: '+ accountList);
    }
    
    public static void testAccount3(List<Account> accountList){
        system.debug('@@@ updateAccount 3: '+ accountList);
        for(Account acc: accountList){
            acc.name = 'Test Account 3';
        }
        system.debug('@@@ updateAccount 3: '+ accountList);
    }
}