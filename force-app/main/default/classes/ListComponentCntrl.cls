public class ListComponentCntrl {  
   @AuraEnabled  
   public static List<Contact> loadData(){  
     List<Contact> conList = [select Id,Name,Email from Contact limit 20];  
     return conList;  
   }  
 }