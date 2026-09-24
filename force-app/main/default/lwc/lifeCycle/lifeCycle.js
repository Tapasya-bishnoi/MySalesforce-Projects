import { LightningElement } from 'lwc';

export default class MyComponent extends LightningElement {

    constructor() {
        super();
        console.log('Component created');
    }

    connectedCallback() {
        console.log('Component connected');
    }

    renderedCallback() {
        console.log('Component rendered');
    }

    disconnectedCallback() {
        console.log('Component removed');
    }

    errorCallback(error, stack) {
        console.log(error);
    }
}