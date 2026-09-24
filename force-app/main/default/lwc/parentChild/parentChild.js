import { LightningElement ,api} from 'lwc';

export default class ParentChild extends LightningElement {

    @api counter = 0;

    @api addHundard(){
        this.counter=this.counter+100;
    }
}