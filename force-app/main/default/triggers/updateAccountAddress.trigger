trigger updateAccountAddress on Contact (after update) {
    Map<Id, Contact> contactMap = trigger.OldMap;
    Map<Id, contact> AccountIdContactMap = trigger.OldMap;
    Set<id> accountIds = new Set<Id>();
    for(Contact con: Trigger.new){
        //if(con.mailingStreet != contactMap.get(con.Id).mailingStreet)
        accountIds.add(con.AccountId);
    }
    List<Account> accList = [Select Id, BillingStreet from Account where id IN: accountIds];
    Set<Account> accounts = new Set<Account>();
    List<Account> accountLst = new List<Account>();
    for(COntact con1: trigger.New){
        for(account acc: accList){
            if(con1.AccountId == acc.Id){
                System.debug('Con1 and Acc : '+ con1.AccountId+'----'+acc.Id);
                acc.billingStreet = con1.mailingStreet;  
                acc.billingCity = con1.mailingCity ;
                acc.billingState = con1.mailingState;
                acc.billingPostalCode = con1.mailingPostalCode;
                acc.billingCountry = con1.mailingCountry;
                accounts.add(acc);
            }
        }
    }
    accountLst.addAll(accounts);
    System.debug('accountLst : '+accountLst);
    update accountLst;
    /*
    contact oldCon = trigger.old[0];
    System.debug('oldCon : '+oldCon);
    COntact con = trigger.new[0];
    Account acc = [Select Id, BillingStreet from Account where id=:con.AccountId];
    
    if(con.mailingStreet != oldCon.mailingStreet || 
        con.mailingCity != oldCon.mailingCity || 
            con.mailingState != oldCon.mailingState || 
                con.mailingPostalCode != oldCon.mailingPostalcode || 
                    con.mailingCountry != oldCon.mailingCountry){
        System.debug('Mailing address is changed...');
        acc.billingStreet = con.mailingStreet;  
        acc.billingCity = con.mailingCity ;
        acc.billingState = con.mailingState;
        acc.billingPostalCode = con.mailingPostalCode;
        acc.billingCountry = con.mailingCountry;        
        update acc; 
    }*/
    
}