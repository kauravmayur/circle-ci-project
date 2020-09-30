public class dynamicsObject {
    
    public list<String> fieldsName{get; set;}
    public string sObjectName{get; set;}
    public void showFields(){
        fieldsName = new List<String>();
        system.debug('sObjectName : '+sObjectName);
        List<String> strList = new List<String>();
        strList.add(sObjectName);
        if(strList.size() > 0){
           Schema.DescribeSobjectResult[] results = Schema.describeSObjects(strList);
           // For each returned result, get some info
            for(Schema.DescribeSobjectResult res : results) {
               Map<String, Schema.SObjectField> fields = res.fields.getMap(); 
               fieldsName.addAll(fields.KeySet());
               
            }
        }
        
 
    }
}