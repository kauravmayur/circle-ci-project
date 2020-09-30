trigger AccountAddressTrigger on Account (Before Insert, Before Update) {
    //List<Account> accountList = Trigger.new;
    List<Account> accL =[Select id,name from account where id IN: Trigger.new];
    system.debug('@@@ accL : '+ accL);
    for(Account acc: Trigger.new){
        if(acc.Match_Billing_Address__c){
            acc.ShippingPostalCode = acc.BillingPostalCode;
        }
    }
    updateAccount.testAccount1(Trigger.new);
    updateAccount.testAccount2(Trigger.new);
    updateAccount.testAccount3(Trigger.new);
}