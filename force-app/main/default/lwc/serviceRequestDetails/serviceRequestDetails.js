import { LightningElement, wire, api } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';

import OWNER_ID from '@salesforce/schema/Case.OwnerId';

import { CurrentPageReference } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ServiceRequestDetails extends LightningElement {

    // CASE RECORD ID
    @api recordId;

    // CASE OWNER ID
    ownerId;

    // DESCRIPTION
    description = '';

    // FILE TYPES
    acceptedFormats = [
        '.pdf',
        '.png',
        '.jpg',
        '.jpeg',
        '.doc',
        '.docx',
        '.xls',
        '.xlsx',
        '.txt',
        '.csv'
    ];

    // GET CASE OWNER

    @wire(getRecord, {
        recordId: '$recordId',
        fields: [OWNER_ID]
    })
    wiredCase({ data, error }){

        if (data){

            // Get current Case Owner Id
            this.ownerId = getFieldValue(data, OWNER_ID);

            console.log(
                'Current Case Owner Id:',
                this.ownerId
            );

        } else if (error){

            console.error(
                'Error loading Case:',
                error
            );
        }
    }

    // OWNER CHANGE

    handleOwnerChange(event) {

        this.ownerId = event.detail.recordId;

        console.log(
            'New Owner Id:',
            this.ownerId
        );
    }

    // GET RECORD ID FROM URL

    @wire(CurrentPageReference)
    getPageReference(pageRef) {

        if (pageRef && pageRef.state) {

            const urlRecordId =pageRef.state.c__recordId;

            if (urlRecordId) {

                this.recordId = urlRecordId;

                console.log('Service Request Details Record Id:',this.recordId);
            }
        }
    }

    // FORM LOAD

    handleFormLoad(event){

        console.log(
            'Case Form Loaded:',
            this.recordId
        );

        try {

            const records = event.detail.records;

            if (
                records &&
                records[this.recordId]
            ) {

                const caseRecord =
                    records[this.recordId];

                if (
                    caseRecord.fields &&
                    caseRecord.fields.Description
                ) {

                    this.description =
                        caseRecord.fields.Description.value || '';
                }
            }

        } catch (error) {

            console.error(
                'Error loading Case:',
                error
            );
        }
    }

    // DESCRIPTION CHANGE

    handleDescriptionChange(event) {

        this.description = event.target.value;
    }

    // SAVE FORM

    handleSubmit(event) {

        // Stop default form submission
        event.preventDefault();

        const fields = event.detail.fields;

        // Set Description
        fields.Description = this.description;

        // Set Case Owner
        fields.OwnerId = this.ownerId;

        console.log(  'Saving Case with Owner Id:',this.ownerId );

        const form =this.template.querySelector( 'lightning-record-edit-form' );

        form.submit(fields);
    }

    // SAVE SUCCESS

    handleSuccess(event) {

        console.log('Case updated:',event.detail.id
        );

        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message:
                    'Case updated successfully.',
                variant: 'success'
            })
        );
    }

    // SAVE ERROR

    handleError(event) {

        console.error(
            'Case update error:',
            event.detail
        );

        let message =
            'Unable to update the Case.';

        if (
            event.detail &&
            event.detail.message
        ) {

            message =
                event.detail.message;
        }

        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Error',
                message: message,
                variant: 'error'
            })
        );
    }

    // FILE UPLOAD

    handleUploadFinished(event) {

        const uploadedFiles =
            event.detail.files;

        console.log(
            'Uploaded Files:',
            uploadedFiles
        );

        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message:
                    uploadedFiles.length +
                    ' file(s) uploaded successfully.',
                variant: 'success'
            })
        );
    }

    // BACK

    handleCancel() {

        window.history.back();
    }
}