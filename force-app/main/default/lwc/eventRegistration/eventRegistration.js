import { LightningElement ,wire } from 'lwc';
import getEvents from '@salesforce/apex/RegistrationController.getEvents';

import  registration from '@salesforce/apex/RegistrationController.registration';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
export default class EventRegistration extends LightningElement {

  Email;
  Name;
  registrationStatus;
  eventOptions = [];
  AssociatedEvent;

@wire(getEvents)
wiredEvents({ data, error }) {
    if (data) {
        this.eventOptions = data.map(evt => ({
            label: evt.Name,
            value: evt.Id
        }));
        console.log('Options:', this.eventOptions);
    } else if (error) {
        console.error('Error loading events', error);
    }
}

    associatedhandle(event) {
        this.AssociatedEvent = event.detail.value;
    }


  emailhandle(event){
     this.Email = event.target.value;
  }

  namehandle(event){
     this.Name = event.target.value;
  }

  registrationstatushandle(event){
     this.registrationStatus= event.target.value;
  }
 

   registration(){

    registration( {
         Email:this.Email,
         Name:this.Name, registrationStatus:this.registrationStatus,AssociatedEvent:this.AssociatedEvent
}
).then(()=>{
     this.dispatchEvent(new ShowToastEvent({ title: 'Success',
                    message: 'Event Created Successfully',
                    variant: 'success'}));
}).catch(error => {
    console.log('FULL ERROR:', error);
    console.log('FULL ERROR JSON:', JSON.stringify(error));

    this.dispatchEvent(
        new ShowToastEvent({
            title: 'Error',
            message:
                error?.body?.message ||
                error?.message ||
                JSON.stringify(error),
            variant: 'error'
        })
    );
});





   }
          
    








   









}