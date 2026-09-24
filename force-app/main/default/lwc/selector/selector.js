import { LightningElement, wire } from 'lwc';
import Id from '@salesforce/user/Id';
import { getRecord } from 'lightning/uiRecordApi';

const FIELDS = ['User.Name'];

export default class Selector extends LightningElement {

    userId = Id;

    @wire(getRecord, {
        recordId: '$userId',
        fields: FIELDS
    })
    user;

    get name() {
        if (this.user && this.user.data) {
            return this.user.data.fields.Name.value;
        }
        return '';
    }
}