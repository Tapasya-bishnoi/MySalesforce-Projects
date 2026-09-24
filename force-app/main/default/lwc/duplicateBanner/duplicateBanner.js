import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

import IS_DUPLICATE from '@salesforce/schema/Contact.Is_Duplicate__c';
import Oiginal_Contact from '@salesforce/schema/Contact.Oiginal_Contact__c';


const FIELDS = [IS_DUPLICATE, Oiginal_Contact];

export default class DuplicateBanner extends LightningElement {

    @api recordId;

    @wire(getRecord, {
        recordId: '$recordId',
        fields: FIELDS
    })
    contact;

    get isDuplicate() {
        return this.contact.data &&
               this.contact.data.fields.Is_Duplicate__c.value;
    }

    get duplicateContactUrl(){
    if (this.contact.data) {
        const duplicateContactId = this.contact.data.fields.Oiginal_Contact__c.value;
        return `/lightning/r/Contact/${duplicateContactId}/view`;
    }
    return null;
}
}