import { LightningElement, api, wire } from 'lwc';

import getQuotes from '@salesforce/apex/OpportunityImp.getQuotes';

import { getRecord } from 'lightning/uiRecordApi';

import OPPSYNC from '@salesforce/schema/Opportunity.OpportunitySync__c';

const FIELDS = [OPPSYNC];

export default class ShowingRelatedQuotes extends LightningElement {

    @api recordId;

    quotes = [];

    showBanner = false;

    // Read Opportunity checkbox
    @wire(getRecord, {
        recordId: '$recordId',
        fields: FIELDS
    })
    opportunity({ data, error }) {

        if (data) {

            const sync =
                data.fields.OpportunitySync__c.value;

            if (sync) {

                this.showBanner = false;

                this.loadQuotes();

            } else {

                this.showBanner = true;

                this.quotes = [];

            }

        }
    }

    loadQuotes() {

        getQuotes({ recordId: this.recordId })

            .then(result => {

                this.quotes = result;

            })

            .catch(error => {

                console.log(error);

            });

    }

    get hasQuotes() {

        return this.quotes.length > 0;

    }

}