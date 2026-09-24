import { LightningElement } from 'lwc';

export default class ChildTransfer extends LightningElement {


handleSubstract(){
    this.dispatchEvent(new CustomEvent('substract'));
}



handleAddition(){
    this.dispatchEvent(new CustomEvent('addition'));
}

  handleMultiply(event){
         const lable = event.target.value;
    this.dispatchEvent(new CustomEvent('multiply' ,{detail : lable}));
  }

}