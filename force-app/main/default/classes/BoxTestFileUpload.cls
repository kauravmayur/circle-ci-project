public class BoxTestFileUpload {
public string code{set;get;}
    public String accessToken{set;get;}
     public String newFolder{set;get;}
    public String Response{get;set;} //response from Box.com
    public blob uploadContent{get;set;}
    public String uploadFilename{get;set;}
    public FoldersInfo folderDetails = new FoldersInfo();
    public String ParentFolderId = '0';
    public Attachment attach {get; set;}
    public Blob AttchBody {get;set;}
    public String AttchDesc {get;set;}
    public String AttchName {get;set;}

    public PageReference requestcode()
    {
        attach = new Attachment();
        ParentFolderId = '110586505236';
        map<String,Box__c> myBox=Box__c.getAll();
        Box__c b=myBox.get('Box');
       // String clientId = 'd3rxgkains2yiz2p70v6wyekucgxgng4';
        String clientId = b.ClientID__c;
        
        /* BoxApiConnection bac;
        // bac = new BoxApiConnection('9SXSR7F723yb3gZU3iCihtCa101171ue');
        bac = new BoxApiConnection(clientId,b.ClientSecret__c  );
        
        
       String accessTok = bac.getAccessToken();
        System.debug('accessTok:::'+accessTok);
        
        String url='https://account.box.com/api/oauth2/authorize?';
        url=url+'response_type=code&client_id='+clientId;
        url=url+'&redirect_uri='+b.RedirectURI__c+'&state=atul98765432123456';
        BoxApiRequest bapi = new BoxApiRequest(url,'POST');
        bapi.timeout  = 12000;
        bapi.send();
      //  bac.authenticate('test');
       // FindFilesFromFolder();
        return null;
       */
        String url='https://account.box.com/api/oauth2/authorize?';
        url=url+'response_type=code&client_id='+clientId;
        url=url+'&redirect_uri='+b.RedirectURI__c+'&state=atul98765432123456';
        code=ApexPages.currentPage().getParameters().get('code');
        if(String.isNotBlank(code))
            requestToken();
       PageReference page=new PageReference(url);
       
        return page;
        
       
    }
    public void requestToken()
    {
        code=ApexPages.currentPage().getParameters().get('code');
        map<String,Box__c> myBox=Box__c.getAll();
        Box__c b=myBox.get('Box');
        String url='https://api.box.com/oauth2/token';
        String body='grant_type=authorization_code';
        system.debug('access token in access method '+accessToken);
        body=body+'&client_id='+b.ClientID__c;
        body=body+'&client_secret='+b.ClientSecret__c;
        body=body+'&code='+code;
        Http p=new Http();
        HttpRequest request =new HttpRequest();
        request.setEndpoint(url);
        request.setMethod('POST');
        request.setBody(body);
        HttpResponse response=p.send(request);
        String result=response.getBody();
        System.JSONParser jp=JSON.createParser(result);
        while(jp.nextToken()!=null)
        {
            System.debug('jp.getText()::::'+jp.getText());

            if(jp.getText()=='access_token')
            {
                jp.nextToken();
                accessToken=jp.getText();
            }
        }
        //uploadFileToBox();
       // CreateFolder();
      // FindFilesFromFolder();
    }
    public void CreateFolder()
    {
        newFolder = 'BoxAccount';
        
        String url='https://api.box.com/2.0/folders';
        String body='{"name":"'+newFolder+'","parent":{"id": '+ParentFolderId +'}}';
        system.debug('test folder :'+newFolder);
        Http p=new Http();
        HttpRequest request=new HttpRequest();
        request.setEndpoint(url);
        request.setMethod('POST');
        request.setHeader('Authorization','Bearer '+accessToken);
        request.setBody(body);
        HttpResponse response=p.send(request);

        String result=response.getBody();
        System.debug('result:::::'+result);
        system.debug('folder is created ');
        folderDetails = new FoldersInfo();
        folderDetails = (FoldersInfo)JSON.deserialize(result,FoldersInfo.class);
        system.debug('********folderDetails :'+folderDetails );
    }
    
    //code to upload files to BOX.COM
   public PageReference uploadFileToBox(){
       Response='';
      
      uploadContent = AttchBody;
      uploadFilename = AttchName;
                blob base64EncodeFile=base64EncodeFileContent(uploadContent,uploadFilename);
             System.debug('base64EncodeFile::::'+base64EncodeFile);
                //blob fileContent=blob.valueof('test String');
                //blob base64EncodeFile=BoxUtility.base64EncodeFileContent(fileContent,'First file Upload');
                // 110908363348
           //     String uploadEndPointURL='https://upload.box.com/api/2.0/files/content?parent_id='+folderDetails.id;
             String uploadEndPointURL='https://upload.box.com/api/2.0/files/content?parent_id=110908363348';
                String boundary = '----------------------------741e90d31eff';
                HttpRequest req = new HttpRequest();
                req.setBodyAsBlob(base64EncodeFile);
                req.setHeader('Content-Type','multipart/form-data; boundary='+boundary);
                req.setHeader('Content-Length',String.valueof(req.getBodyAsBlob().size()));
                req.setHeader('Authorization', 'Bearer ' + accessToken);
               system.debug('access token '+accessToken);
                req.setMethod('POST');
                req.setEndpoint(uploadEndPointURL);
                req.setMethod('POST');
                req.setTimeout(120000);
                //Send request to Box
                Http p=new Http();
                HTTPResponse res=p.send(req);
                Response=res.getBody();
                System.debug('**Files upload Response:'+Response);
                Integer uploadStatusCode=res.getStatusCode();
                if(uploadStatusCode==201){
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'File uploaded successfully.'));
                }else{
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Error encountered. Status Code;'+uploadStatusCode));
                }
          
       return null;
   }
   
   //reference :http://blog.enree.co/2013/01/salesforce-apex-post-mutipartform-data.html
    public blob base64EncodeFileContent(Blob file_body, String file_name){
        String boundary = '----------------------------741e90d31eff';
        String header = '--'+boundary+'\nContent-Disposition: form-data; name="file"; filename="'+file_name+'";\nContent-Type: application/octet-stream';
        String footer = '--'+boundary+'--';             
        String headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n\r\n'));
        while(headerEncoded.endsWith('='))
        {
            header+=' ';
            headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n\r\n'));
        }
        String bodyEncoded = EncodingUtil.base64Encode(file_body);
        Blob bodyBlob = null;
        String last4Bytes = bodyEncoded.substring(bodyEncoded.length()-4,bodyEncoded.length());
 
        if(last4Bytes.endsWith('==')) {
            last4Bytes = last4Bytes.substring(0,2) + '0K';
            bodyEncoded = bodyEncoded.substring(0,bodyEncoded.length()-4) + last4Bytes;
            String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
            bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);
        } else if(last4Bytes.endsWith('=')) {
            last4Bytes = last4Bytes.substring(0,3) + 'N';
            bodyEncoded = bodyEncoded.substring(0,bodyEncoded.length()-4) + last4Bytes;
            footer = '\n' + footer;
            String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
            bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);              
        } else {
            footer = '\r\n' + footer;
            String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
            bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);  
        }
 
        return bodyBlob;
    }
    
    //****code to find files present in different folders
    public Pagereference FindFilesFromFolder(){
      //  Response='';
      //  FileViewUrl='';
     //   folderDetails = new FoldersInfo();
      //  fileList=new List<entry>();
        if(true){
            String endpointURLForFiles = 'https://api.box.com/2.0/folders/'+ParentFolderId;
            system.debug('*******endpointURLForFiles '+endpointURLForFiles );
            Map<String,String>headers=new Map<String,String>();
            headers.put('Content-Type','application/x-www-form-urlencoded');
            headers.put('Accept','application/json');
            headers.put('Authorization','Bearer ' + accessToken);
            HTTPRequest req=createHTTPReq('', endpointURLForFiles ,'GET',headers);
            
            //Now send request to fetch files details
            HTTPResponse res=sendHttpRequest(req);
            Response=res.getBody();
            System.debug('**Files Response:'+Response);
            
            //parse file response json
            FoldersInfo folderDetails = (FoldersInfo )JSON.deserialize(Response,FoldersInfo.class);
         //   system.debug('********folderDetails :'+folderDetails );
            //find file list from respone to display in ui
         //   FindFileList(folderDetails);
        }else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please select folder.'));
        }
        return null;
    }
    //Method to do call out to Box
    public HTTPResponse sendHttpRequest(HTTPRequest req){
        Http http = new Http();
        HTTPResponse res = http.send(req);
        System.debug('****response body:'+res.getBody());
        return res;
    }
    //Method to generate HTTPRequest for call out
    public HTTPRequest createHTTPReq(String reqBody, string reqEndPoint, string reqMethod, Map<String,String> headersMap){
        HttpRequest req = new HttpRequest();
        req.setEndpoint(reqEndPoint);
        req.setMethod(reqMethod);
        if(reqBody!=null && reqBody!=''){
            req.setbody(reqBody);
        }
        if(headersMap.size()>0){
            for(String ss : headersMap.keyset()){
                req.setHeader(ss,headersMap.get(ss));   
            }
        }
        req.setTimeout(120000);
        return req;
    }
    
    
    
    //apex class structure to deserialize Folder response JSON
    public class FoldersInfo{
        public String type{get;set;}
        public String id{get;set;}
        public String sequence_id{get;set;}
        public String etag{get;set;}
        public String name{get;set;}
        public String created_at{get;set;}
        public String modified_at{get;set;}
        public String item_status{get;set;}
        public String description{get;set;}
        public itemCollections item_collection{get;set;}
        public FoldersInfo(){}
        public FoldersInfo(String type,String id,String sequence_id,String etag,String name,String created_at,String modified_at,String description,String item_status ){
            this.type=type;
            this.id=id;
            this.sequence_id=sequence_id;
            this.etag=etag;
            this.created_at=created_at;
            this.modified_at=modified_at;
            this.description=description;
            this.item_status=item_status;
            this.item_collection=new itemCollections();
            
        }
    }
    
    public class itemCollections{
        public String total_count{get;set;}
        public List<entry> entries{get;set;}
        public itemCollections(){}
        public itemCollections(String count){
            this.total_count=count;
            this.entries=new list<entry>();  
        }
    }
    
    public class entry{
        public String type{get;set;}
        public String id{get;set;}
        public String name{get;set;}
        public entry(String type,String id,String name){
            this.type=type;
            this.id=id;
            this.name=name;
        }   
    }
    
    //*************************************
    public class AppAuth
    {
        public string publicKeyID { get; set; }
        public string privateKey { get; set; }
        public string passphrase { get; set; }
    }
    
    public class BoxAppSettings
    {
        public string clientID { get; set; }
        public string clientSecret { get; set; }
        public AppAuth appAuth { get; set; }
    }
    
    public class RootObject
    {
        public BoxAppSettings boxAppSettings { get; set; }
        public string enterpriseID { get; set; }
    }
    //
}