public class TestEinsteinClas {
    public static String getAccessToken() {
        // Ignore the File upload part and "jwt.pkcs" if you used a Salesforce certificate to sign up 
        // for an Einstein Platform account
        ContentVersion base64Content = [SELECT Title, VersionData FROM ContentVersion where Title='einstein_platform' OR  Title='predictive_services' ORDER BY Title LIMIT 1];
        String keyContents = base64Content.VersionData.tostring();
        keyContents = keyContents.replace('-----BEGIN RSA PRIVATE KEY-----', '');
        keyContents = keyContents.replace('-----END RSA PRIVATE KEY-----', '');
        keyContents = keyContents.replace('\n', '');
		
        System.debug('keyContents : '+keyContents);
        // Get a new token
        
        JWT jwt = new JWT('RS256');
        // jwt.cert = 'JWTCert'; // Uncomment this if you used a Salesforce certificate to sign up for an Einstein Platform account
        jwt.pkcs8 = keyContents; // Comment this if you are using jwt.cert
        jwt.iss = 'developer.force.com';
        jwt.sub = 'mayursinghkaurav@gmail.com';
        jwt.aud = 'https://api.einstein.ai/v2/oauth2/token';
        jwt.exp = '3600';
		String access_token = JWTBearerFlow.getAccessToken('https://api.einstein.ai/v2/oauth2/token', jwt);
        /*
        Einstein_JWT jwt = new Einstein_JWT('RS256');
        jwt.pkcs8 = keyContents; // Comment this if you are using jwt.cert
        jwt.iss = 'developer.force.com';
        jwt.sub = 'mayursinghkaurav@gmail.com';
        jwt.aud = 'https://api.einstein.ai/v2/oauth2/token';
        jwt.exp = '3600';
        String access_token = Einstein_JWTBearerFlow.getAccessToken('https://api.einstein.ai/v2/oauth2/token', jwt);
        */
		
        system.debug('access_token : '+access_token);
        return access_token;    
    }
    
    //method1 in awsFileTest.apex
    public static void createDatasetFromUrl(String zipUrl,string typeString) {
        Einstein_PredictionService  service = new Einstein_PredictionService ();
        service.createDatasetFromUrlAsync(zipUrl,typeString);
        system.debug(service);
    }

}