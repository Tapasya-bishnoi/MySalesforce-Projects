import { subscribe ,MessageContext } from 'lightning/messageService';
import { LightningElement,wire } from 'lwc';
import Counting_Channel from '@salesforce/messageChannel/Counting__c';


export default class SubLwc extends LightningElement {

   counter =0;
   subscription=null;

   @wire(MessageContext)
   messageContext

  connectedCallback(){
   this.subscribeToMessageChannel();
}

subscribeToMessageChannel(){
   
    this.subscription= subscribe(this.messageContext,Counting_Channel,(message) =>this.handleThis(message));

}

handleThis(message){


    //alert("message"+JSON.stringify(message));

   if(message.operator == 'add'){
    this.counter = this.counter+message.constant;
   }

   if(message.operator == 'substract'){
    this.counter = this.counter-message.constant;
   }
  
   if(message.operator == 'multiply'){
    this.counter = this.counter*message.constant;
   }


}




}