trigger account_24 on Account (after insert) {
   /* list<Account> acctlist=new list<Account>();
   acctlist=[ select name,billingcity from account];
    system.debug('value is :'+acctlist);*/
    
    List<Contact> conList = new List<Contact>();
    for(account actobj:Trigger.new)
    {
       contact con = new Contact();
       system.debug('debug value is:'+actobj); 
       if (actobj.Name=='Rajendra')
         {
            
            con.AccountId=actobj.Id;
            con.LastName='Gupta';
             
         }

        System.debug('debug con value is: '+con);
        conList.add(con);

    }
    insert conList;
              
}