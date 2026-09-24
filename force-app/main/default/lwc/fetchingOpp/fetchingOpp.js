import { LightningElement, track } from 'lwc';

import getOpenOpportunities from '@salesforce/apex/OpportunityController.getOpenOpportunities';
import getClosedWonOpportunities from '@salesforce/apex/OpportunityController.getClosedWonOpportunities';

export default class OpportunityList extends LightningElement {

    @track opportunities;

    connectedCallback() {
        this.showOpen();
    }

    showOpen() {

        getOpenOpportunities()
            .then(result => {
                this.opportunities = result;
            })
            .catch(error => {
                console.error(error);
            });
    }

    showClosedWon() {

        getClosedWonOpportunities()
            .then(result => {
                this.opportunities = result;
            })
            .catch(error => {
                console.error(error);
            });
    }
}