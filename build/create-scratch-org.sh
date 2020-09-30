# Get the private key from the environment variable
echo "Setting up DevHub Connection..."
mkdir keys
openssl version
openssl aes-256-cbc -salt -a -d -in assets/server.key.enc -out assets/server.key -pbkdf2 -k $SERVER_KEY_PASSWORD
#echo $SFDC_SERVER_KEY | base64 -di > keys/server.key

# Authenticate to salesforce 
echo "Authenticating..."
sfdx force:auth:jwt:grant --clientid $SFDC_PROD_CLIENTID --jwtkeyfile assets/server.key --username $SFDC_PROD_USER --setdefaultdevhubusername -a DevHub

#Create a scratch org
echo "Creating the Scratch Org..."
sfdx force:org:create -f config/project-scratch-def.json -a ${CIRCLE_BRANCH} -s