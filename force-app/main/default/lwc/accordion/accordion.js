import { LightningElement, wire,track } from 'lwc';
import allAccountsWithContacts from '@salesforce/apex/ContactController.allAccountsWithContacts';

export default class Accordion extends LightningElement {
@track activeSessionMessage = '';
@track data = [];
@track multiple = true;
@track accounts ;
handleToggleSection(event){
    this.activeSessionMessage = 'Open section name: ' + event.detail.openSections;
}
//@wire(allAccountsWithContacts) accounts;
@wire(allAccountsWithContacts) 
wiredAccountss({
    error,
    data
    }) {
    if (data) {
        this.accounts = data;
        // eslint-disable-next-line no-console
        console.log(data);
        // eslint-disable-next-line no-console
        console.log(JSON.stringify(data, null, '\t'));
        
        data.forEach(function (item, key) {
            // eslint-disable-next-line no-console
            console.log(key); 
            // eslint-disable-next-line no-console
            console.log(item); 
        });
        
    } else if (error) {
        this.error = error;
    }
    }
/*
async connectedCallback() {
    
    console.log('*** connectedCallback ***');
    const datavalue = await allAccountsWithContacts();
    //const datavalue= await getContactList({ opportunityId: this.recordId });
    //const datavalue1= await getPOC({});  
    //const datavalue2= await getUserRoles();  
    console.log('datavalue : '+datavalue);
    this.data=datavalue;
    
    for(i=0; i<datavalue.length; i++)  {    
        this.itemsPOC = [...this.itemsPOC ,{"disabled":false,"escapeItem":false,"label":datavalue1[i].label,"value":datavalue1[i].value}];        
    }
    

    
}
*/

}

/*
import {LightningElement,api,wire,track} from 'lwc';
import getAccountData from '@salesforce/apex/GetAccountContactData.getAccountData';

export default class AccordionEx extends LightningElement {
@track multiple = true;
@track accounts ;
@wire(getAccountData) 
wiredAccountss({
error,
data
}) {
if (data) {
    this.accounts = data;
    console.log(data);
    console.log(JSON.stringify(data, null, '\t'));
    
    data.forEach(function (item, key) {
        console.log(key); 
        console.log(item); 
    });
    
} else if (error) {
    this.error = error;
}
}

}
*/