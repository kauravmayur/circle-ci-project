public with sharing class inlineEditCtrl {
    
    //List displayed on UI
    
    public inlineEditCtrl(){
        //Initialize
        
    }
    // method to fetch all object list
    @AuraEnabled
    public static List<String> fetchObjects(){
        List<String> supportedObject = new List<String>();
        //Get only reference to objects
        for(Schema.SObjectType item : ProcessInstance.TargetObjectId.getDescribe().getReferenceTo())
        {
            //Excluding custom setting objects
            if(!item.getDescribe().CustomSetting)
            {
                //supportedObject = new List<selectoption>() ;
                //Adding to list
                //supportedObject.add(new SelectOption(item.getDescribe().getLocalName().toLowerCase() , item.getDescribe().getLabel() ));
                supportedObject.add(item.getDescribe().getLocalName().toLowerCase());
            }
        }
        return supportedObject;
    }

    //Get fields of selected object
    @AuraEnabled
    public static List<Map<String,String>> ObjectFields(String SelectedObject)
    {
        system.debug('SelectedObject : '+SelectedObject);
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        Set<String> objectKeys = gd.keySet();
        List<Map<String,String>> multiPicklistValues = new List<Map<String,String>> ();
        if(String.isNotBlank(SelectedObject))
        {
            //Creating sObject for dynamic selected object
            Schema.SObjectType systemObjectType = gd.get(SelectedObject);
            //Fetching field results
            Schema.DescribeSObjectResult r = systemObjectType.getDescribe();
    
            Map<String, Schema.SObjectField> M = r.fields.getMap();
            //Creating picklist of fields
            for(Schema.SObjectField fieldAPI : M.values())
            {
                string field = fieldAPI.getDescribe().getName();
                Map<String,String> dataMap = new Map<String,String>();
                dataMap.put('label', fieldAPI.getDescribe().getLabel());
                dataMap.put('value', fieldAPI.getDescribe().getName());
                multiPicklistValues.add(dataMap);
            }
        }
        return multiPicklistValues;
    }
    @AuraEnabled
    public static List<sObject> ShowTable(String SelectedObject, List<String> SelectedFields)
    {
        List<sObject> ObjectList = new List<sObject>();
        //Creating dynamic query with selected field
        String myQuery = 'Select Id ' ;
        
        for(String field : SelectedFields)
        {
            if(field.toLowerCase() != 'id' && field.toLowerCase() != '--none--')
            myQuery += ','+ field + ' ' ;
        }
        
        //Limit is 100 for now you can change it according to need
        myQuery += ' from ' + SelectedObject + ' LIMIT 100' ;
        
        //Executing the query and fetching results
        ObjectList = Database.query(myQuery) ;
        return ObjectList;
    }

    // method for fetch account records list  
    @AuraEnabled
    public static List < account > fetchAccount() {
        
        List < Account > returnList = new List < Account > ();
        List < Account > lstOfAccount = [select Id, Name, Rating, Website,CreatedDate,CreatedById, Type,AnnualRevenue from account ];
        
        for (Account acc: lstOfAccount) {
            returnList.add(acc);
        }
        return returnList;
    }
    
  // method for update records after inline editing  
    @AuraEnabled
    public static List < account > saveAccount(List<Account> lstAccount) {
        update lstAccount;
        return lstAccount;
    }
    
  // method for fetch picklist values dynamic  
    @AuraEnabled
    public static List < String > getselectOptions(sObject objObject, string fld) {
        system.debug('objObject --->' + objObject);
        system.debug('fld --->' + fld);
        List < String > allOpts = new list < String > ();
        // Get the object type of the SObject.
        Schema.sObjectType objType = objObject.getSObjectType();
        
        // Describe the SObject using its object type.
        Schema.DescribeSObjectResult objDescribe = objType.getDescribe();
        
        // Get a map of fields for the SObject
        map < String, Schema.SObjectField > fieldMap = objDescribe.fields.getMap();
        
        // Get the list of picklist values for this field.
        list < Schema.PicklistEntry > values =
            fieldMap.get(fld).getDescribe().getPickListValues();
        
        // Add these values to the selectoption list.
        for (Schema.PicklistEntry a: values) {
            allOpts.add(a.getValue());
        }
        system.debug('allOpts ---->' + allOpts);
        allOpts.sort();
        return allOpts;
    }
}