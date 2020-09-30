public class EinsteinAPI1 {
    public Static Einstein_API_Settings__c settings        {
        get {
            return Einstein_API_Settings__c.getInstance( UserInfo.getOrganizationId() );
        }
    } 
    public static String tokenEndpoint             {
        get {
            return settings.Token_Endpoint__c;
        }
    }
    public static Decimal tokenExpirationSeconds   {
        get {
            return settings.Token_Expiration_Seconds__c;
        }
    }
    public static String registeredEmail           {
        get {
            return settings.Registerd_Email__c;
        }
    }
   
    
    public Static String intentUploadDatasetEP             {
        get {
            return settings.Intent_Upload_Dataset_Endpoint__c;
        }
    }
    public Static String intentDatasetDetailsEP            {
        get {
            return settings.Intent_Dataset_Details_Endpoint__c;
        }
    }
    public Static String intentTrainDatasetEP              {
        get {
            return settings.Intent_Train_Dataset_Endpoint__c;
        }
    }
    public Static String intentDatasetTrainingStatusEP     {
        get {
            return settings.Intent_Dataset_Training_Status_Endpoint__c;
        }
    }
    public Static String predictIntentEP                   {
        get {
            return settings.Predict_Intent_Endpoint__c;
        }
    }
    public Static String intentDatasetCSV                  {
        get {
            return settings.Intent_Dataset_CSV__c;
        }
    }
    
    public Static String getAccessTokens() {        
       ContentVersion base64Content = [
            SELECT  Title
                    ,VersionData
            FROM    ContentVersion
            WHERE   Title = 'einstein_platform'
            OR      Title = 'predictive_services'
            ORDER BY Title
            LIMIT 1
        ];
        String keyContents  = base64Content.VersionData.tostring();
        system.debug('key Contents= '+keyContents);
        keyContents         = keyContents.replace( '-----BEGIN RSA PRIVATE KEY-----', '' );
        keyContents         = keyContents.replace( '-----END RSA PRIVATE KEY-----', '' );
        keyContents         = keyContents.replace( '\n', '' );
        JWT jwt             = new JWT( 'RS256' );
        jwt.pkcs8           = keyContents; 
        jwt.iss             = 'developer.force.com';
        jwt.sub             = registeredEmail;
        jwt.aud             = tokenEndpoint;
        jwt.exp             = String.valueOf(tokenExpirationSeconds);
        String access_token = JWTBearerFlow.getAccessToken( EinsteinAPI.tokenEndpoint, jwt );
        system.debug('access token is: '+access_token);
        return access_token;
        
    }
    
    public Static DatasetUploadResponse makePostCallout() {
        /*
        string endpoint = 'https://api.einstein.ai/v2/language/datasets/upload';
        HttpRequest httpReq = buildRequest( 'POST', endpoint );
        
        String mutipartFormData = '';
        mutipartFormData += HttpFormBuilder.WriteBoundary();
        mutipartFormData += HttpFormBuilder.WriteBodyParameter( 'path', intentDatasetCSV);
        mutipartFormData += HttpFormBuilder.WriteBoundary();
        mutipartFormData += HttpFormBuilder.WriteBodyParameter( 'type', 'text-intent' );
        mutipartFormData += HttpFormBuilder.WriteBoundary( NULL );
        
        Blob formBlob = EncodingUtil.base64Decode( mutipartFormData );
        
        httpReq.setBodyAsBlob( formBlob );

        Http http = new Http();
        
        HTTPResponse httpRes = http.send( httpReq );
        system.debug('httpRes : '+httpRes.getBody());
        
        return httpRes;
		*/
        //String endpoint = intentUploadDatasetEP;
        string endpoint = 'https://api.einstein.ai/v2/language/datasets/upload';
        HttpRequest httpReq = buildRequest( 'POST', endpoint );
        
        String mutipartFormData = '';
        mutipartFormData += HttpFormBuilder.WriteBoundary();
        mutipartFormData += HttpFormBuilder.WriteBodyParameter( 'path', intentDatasetCSV );
        mutipartFormData += HttpFormBuilder.WriteBoundary();
        mutipartFormData += HttpFormBuilder.WriteBodyParameter( 'type', 'text-intent' );
        mutipartFormData += HttpFormBuilder.WriteBoundary( NULL );
        
        Blob formBlob = EncodingUtil.base64Decode( mutipartFormData );
        
        httpReq.setBodyAsBlob( formBlob );

        Http http = new Http();
        
        HTTPResponse httpRes = http.send( httpReq );
        system.debug('GET Response is: '+httpRes.getBody());
        DatasetUploadResponse resp = new DatasetUploadResponse();
        
        resp = ( DatasetUploadResponse ) JSON.deserialize( httpRes.getBody(), DatasetUploadResponse.class );
        system.debug('resp: '+resp);
        return resp;
    }
    
    public static DatasetDetailsResponse getDatasetDetails( String datasetId ) {
        
        String endpoint = intentDatasetDetailsEP+'/'+datasetId;
        //String endpoint = intentDatasetDetailsEP.replace( '#DSID#', datasetId );
        HttpRequest httpReq = buildRequest( 'GET', endpoint );
        
        Http http = new Http();
        
        HTTPResponse httpRes = http.send( httpReq );
        system.debug('GET Response is: '+httpRes.getBody());
        
        DatasetDetailsResponse resp = new DatasetDetailsResponse();
        
        resp = ( DatasetDetailsResponse ) JSON.deserialize( httpRes.getBody(), DatasetDetailsResponse.class );
        
        return resp;
	    
        
    }
    
    private static HttpRequest buildRequest( String method, String endpoint ) {
        HttpRequest httpReq = new HttpRequest();
        
        httpReq.setMethod( method );
        httpReq.setEndpoint( endpoint );
        
        //httpReq.setHeader( 'Authorization', 'Bearer ' + 'S2BBVJA2K4V3CX76RZFGHDGQ5N4NCOYCAT7IQXQ5LECBVE6W5JAB7Z3G5MBVLVITXPYTRXC3WE4G2OEBMSFAZEOWG5D4ILGHO3Q4K2I');
        httpReq.setHeader( 'Authorization', 'Bearer ' + getAccessTokens());
        httpReq.setHeader( 'Cache-Control', 'no-cache' );
        httpReq.setHeader( 'Content-Type', HttpFormBuilder.GetContentType() );
        //httpReq.setHeader( 'Content-Type', HttpFormBuilder.GetContentType() );
        //httpReq.setHeader('type', 'text-intent');
        
        
        httpReq.setTimeout( 120000 );
        system.debug('httpReq : '+httpReq.getBody());
        return httpReq;
    }
    
	

}