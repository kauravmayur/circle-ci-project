global class myWebService{
  webservice static Id makeContact(String lastName, Account a){
    system.debug('---- lastname : ' + lastname);
    system.debug('---- a : ' + a);
    contact c = new contact(lastName = lastName, AccountId = a.id);
    insert c;
    return c.id;
  }
}