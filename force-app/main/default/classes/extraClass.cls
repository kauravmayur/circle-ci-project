public without sharing class extraClass {
    public extraClass(){
            List<Contact> conlist = [Select Id, Name from Contact];
            System.debug('extraClass conlist : '+conlist.size());
        }
}