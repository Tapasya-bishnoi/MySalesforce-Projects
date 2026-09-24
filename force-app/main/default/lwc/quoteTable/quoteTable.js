import { LightningElement, api, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getQuotes from '@salesforce/apex/QuoteController.getQuotes';

const COLUMNS = [
    { label: 'Quote Number', fieldName: 'Name' },
    { label: 'Status', fieldName: 'SBQQ__Status__c' },
    { label: 'Net Amount', fieldName: 'SBQQ__NetAmount__c', type: 'currency' }
];

export default class QuoteTable extends NavigationMixin(LightningElement) {

    @api recordId;

    columns = COLUMNS;
    quotes = [];

    @wire(getQuotes, { recordId: '$recordId' })
    wiredQuotes({ error, data }) {
        if (data) {
            this.quotes = data;
        } else if (error) {
            console.error(error);
        }
    }

    handleViewAllQuotes(){
        this[NavigationMixin.Navigate]({
            type: 'standard__recordRelationshipPage',
            attributes: {
                recordId: this.recordId,
                objectApiName: 'Opportunity',
                relationshipApiName: 'SBQQ__Quotes2__r',
                actionName: 'view'
            }
        });
    }
}