import { LightningElement, wire, api } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

const FIELDS = [
    'Contact.FirstName',
    'Contact.LastName',
    'Contact.Email',
    'Contact.Phone'
];

export default class LdsDemo extends LightningElement {

    @api recordId;

    @wire(getRecord, {
        recordId: '$recordId',
        fields: FIELDS
    })
    contact;

    get firstName() {
        return this.contact.data?.fields?.FirstName?.value;
    }

    get lastName() {
        return this.contact.data?.fields?.LastName?.value;
    }

    get email() {
        return this.contact.data?.fields?.Email?.value;
    }

    get phone() {
        return this.contact.data?.fields?.Phone?.value;
    }
}