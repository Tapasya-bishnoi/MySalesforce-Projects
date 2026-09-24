import{ LightningElement } from 'lwc';

export default class ChildToParent extends LightningElement {

    countValue = 0
    
    handleDecree(){
       this.countValue--;
    }

   handleIncree(){
    this.countValue++;
   }

   handleMultiplication(event){
      const mulValue = event.detail;
      this.countValue=this.countValue*mulValue;
   }

}