import { LightningElement ,wire} from 'lwc';
import { publish ,MessageContext } from 'lightning/messageService';
import Counting_Channel from '@salesforce/messageChannel/Counting__c';

export default class PubLwc extends LightningElement {


@wire(MessageContext)
 messageContext;

handleAdd(){
    const payLoad={
        operator:'add',
        constant : 1
    }
    publish(this.messageContext,Counting_Channel,payLoad);
}
handleSub(){
    const payLoad={
        operator:'substract',
        constant : 1
    }

     publish(this.messageContext,Counting_Channel,payLoad);
}

handleMul(){
    const payLoad={
        operator:'multiply',
        constant : 2
    }

     publish(this.messageContext,Counting_Channel,payLoad);
}


}