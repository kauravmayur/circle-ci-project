#Install dependencies, SFDX CLI in this case
echo "Installing Dependencies... "
sudo npm install -global sfdx-cli
sfdx update
sfdx --version
sfdx plugins:install salesforcedx@49.2.3
sfdx plugins --core