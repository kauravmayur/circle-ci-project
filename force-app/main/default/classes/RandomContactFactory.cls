public class RandomContactFactory{
    public static List<Contact> generateRandomContacts(Integer i, String lastName){
        List<Contact> contactList = new List<Contact>();
        for(integer j = 1; j<= i; j++){
            Contact con = new Contact();
            con.firstName = 'testFN'+j;
            con.LastName = lastName;
            contactList.add(con);
        }
        return contactList;
    }
}