import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';

import IS_VIP from '@salesforce/schema/Contact.Is_VIP__c';
import VIP_REASON from '@salesforce/schema/Contact.VIP_Reason__c';
import VIP_SINCE_DATE from '@salesforce/schema/Contact.VIP_Since_Date__c';

const FIELDS = [
    IS_VIP,
    VIP_REASON,
    VIP_SINCE_DATE
];

export default class VipBanner extends LightningElement {

    @api recordId;

    isVip = false;
    vipReason;
    vipSinceDate;

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    wiredContact({ error, data }) {

        if (data) {
            this.isVip = getFieldValue(data, IS_VIP);
            this.vipReason = getFieldValue(data, VIP_REASON);
            this.vipSinceDate = getFieldValue(data, VIP_SINCE_DATE);
        } else if (error) {
            console.error(error);
        }
    }
}