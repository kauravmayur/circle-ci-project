public class HrAppController {
    @AuraEnabled
    public static user getUserDetails(){
        User users = [SELECT ID,Name,Manager.Name, ManagerId FROM User WHERE Id =: Userinfo.getUserId()];
        return users;
    }
    @AuraEnabled
    public static void saveLeave(date startDate){
        Leave__c leave = new Leave__c();
        system.debug('startDate : '+startDate);
        leave.Start_Date__c = startDate;
        insert leave;
    }
}