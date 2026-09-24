import { LightningElement } from 'lwc';
import createEvent
from '@salesforce/apex/EventController.createEvent';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
export default class EventCreation extends LightningElement {

     eventName;
     eventDate;
     
    handleEventName(event){
       this.eventName =  event.target.value;
    //    console.log(this.eventName);
}

    
    handleEventDate(event){
   this.eventDate = event.target.value;
//    console.log(this.eventDate);
        }





createEvent(){

  createEvent(
{ eventName:this.eventName,
    eventDate:this.eventDate,
}).then(()=>{

    this.dispatchEvent(
       new ShowToastEvent({
                 title: 'Success',
                    message: 'Event Created Successfully',
                    variant: 'success'
        })
    );
}).catch(error=>{

 this.dispatchEvent(
new ShowToastEvent({ title: 'Error',
                    message: error.body.message,
                    variant: 'error'})
 );

});

}




}