import { LightningElement } from 'lwc';

export default class ParentToChild extends LightningElement {
        startCounter = 0;

        handleStartChange(event){
                this.startCounter = Number(event.target.value);
        }

       addChange(){

        const add = this.template.querySelector('c-parent-Child');
           add.addHundard();
       }


}