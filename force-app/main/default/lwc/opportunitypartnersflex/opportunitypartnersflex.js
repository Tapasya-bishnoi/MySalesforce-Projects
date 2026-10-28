import { LightningElement } from 'lwc';
import getFlexTemplateResponse from "@salesforce/apex/OpportunityToPartner.getFlexTemplateResponse";
export default class Opportunitypartnersflex extends LightningElement {
  oppValue;
  isLoading=false;
  response;
  assignOpp(event){
    this.oppValue= event.target.value;
  }
  fieldRelation(){
     getFlexTemplateResponse({OppName:this.oppValue}).then(
        result=>{
            this.response = result;
            this.isLoading = false;
        }
     ).catch(error=>{
        console.log( "this is error "+JSON.stringify(error));
        this.isLoading=false;
     })  

}
}