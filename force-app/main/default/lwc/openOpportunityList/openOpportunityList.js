import { LightningElement, wire } from 'lwc';

import getOpenOpportunities from '@salesforce/apex/OpenOpportunity.getOpenOpportunities';

import updateOpportunityStage from '@salesforce/apex/OpenOpportunity.updateOpportunityStage';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class OpenOpportunityList extends LightningElement {


// Store Opportunities
    opportunities = [];

// Controls which section is visible
    showActionPage = false;

 // Selected Opportunity Id
    selectedOpportunityId;

 // Selected Opportunity Name
    selectedOpportunityName;


    // Get Open Opportunities
    @wire(getOpenOpportunities)
    wiredOpportunities({ data, error }) {

        if (data) {
            this.opportunities = data;
          }
        else if (error) {
            console.error(error);
          }
    }


    
    // ACTION BUTTON
    
handleAction(event){
   // Get Opportunity Id
    this.selectedOpportunityId = event.target.dataset.id;
            
   // Find selected Opportunity
    const selectedOpportunity =this.opportunities.find( opp => opp.Id === this.selectedOpportunityId );
            
                
// Store Opportunity Name
        this.selectedOpportunityName =  selectedOpportunity.Name;

          
// Hide list
// Show action page
         this.showActionPage = true;
    }


    
    // CLOSED WON
      handleWon() {
       this.updateStage('Closed Won');
    }


    
    // CLOSED LOST
    handleLost() {
      this.updateStage('Closed Lost');
     }


    
    // UPDATE STAGE
    updateStage(stage) {
     updateOpportunityStage({
         opportunityId:this.selectedOpportunityId,stage:stage
                }).then(() => {// Success message
              this.dispatchEvent(new ShowToastEvent({title: 'Success',
                 message:this.selectedOpportunityName +' is now ' +stage,variant: 'success'}));


            // Remove closed Opportunity
            this.opportunities =
                this.opportunities.filter( opp =>opp.Id !== this.selectedOpportunityId);


            // Go back to Opportunity List
            this.showActionPage = false;


            // Clear selected Opportunity
            this.selectedOpportunityId = null;
            this.selectedOpportunityName = null;

        })

        .catch(error => {

            console.error(error);


            this.dispatchEvent(
                new ShowToastEvent({title: 'Error',message:error.body?.message ||'Something went wrong',variant: 'error'})
            );
     });
    }

}