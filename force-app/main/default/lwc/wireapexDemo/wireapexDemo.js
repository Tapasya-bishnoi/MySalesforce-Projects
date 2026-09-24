import { LightningElement, api, wire } from 'lwc';
import listOfCon from '@salesforce/apex/ContactController.listOfCon';
import NAME_FIELD from '@salesforce/schema/Account.Name';

import {getRecord} from 'lightning/uiRecordApi';

export default class wireapexDemo extends LightningElement {

   @api recordId;
   contacts;
   error;

   @wire(getRecord ,{recordId :'$recordId' , fields:[NAME_FIELD]})
   record;
   @wire(listOfCon, {accId:'$recordId'})
    wiredContact({error , data}){
      if(data){
        this.contacts = data;
        this.error = undefined;
      }
      else if(error)
{
  this.error = data;
  this.contacts = undefined;
}

    }
  
get name() {
   return this.record.data ? this.record.data.fields.Name.value : '';
}  

}