import { LightningElement } from 'lwc';

export default class QuerySelectorBinding extends LightningElement {


    Greetings ='tapasya';

    handlerBinding(event){
       
        this.Greetings= this.template.querySelector("lightning-input").value;
}
}