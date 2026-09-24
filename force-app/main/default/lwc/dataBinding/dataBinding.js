import { LightningElement } from 'lwc';

export default class DataBinding extends LightningElement {
    
   FirstName = '';
   LastName = '';


   handlerBinding(event){

    const x = event.target.name;
    if(x===fname){
        this.FirstName = event.target.value;
    } else if(x===lname){
        this.LastName = event.target.value;
    }
}


get uppercasedFullName(){
    return `${this.FirstName} ${this.LastName}`.toUpperCase;
}

}