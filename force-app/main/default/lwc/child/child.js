import { api, LightningElement } from 'lwc';

export default class Child extends LightningElement {

  uppercaseItem = '';

    @api
    get itemName(){
        return this.uppercaseItem;
    }
    set itemName(value){
        this.uppercaseItem = value?value.toUpperCase() : '';
    }
    }