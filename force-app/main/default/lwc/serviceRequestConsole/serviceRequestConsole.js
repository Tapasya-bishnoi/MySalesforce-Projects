import { LightningElement, wire } from 'lwc';

import getServiceRequests from '@salesforce/apex/ServiceRequestController.getServiceRequests';

import getTotalRecords from '@salesforce/apex/ServiceRequestController.getTotalRecords';

import { NavigationMixin } from 'lightning/navigation';

import { deleteRecord } from 'lightning/uiRecordApi';

import { refreshApex } from '@salesforce/apex';

export default class ServiceRequestConsole extends NavigationMixin(LightningElement) {

    //Selected Cases

    selectedRows = [];

    wiredCasesResult;
    wiredTotalRecordsResult;



    // VARIABLES

    cases = [];

    searchKey = '';

    status = 'All';

    priority = 'All';

    origin = 'All';


    // PAGINATION

    pageNumber = 1;

    pageSize = 10;

    totalRecords = 0;

    totalPages = 1;


    // SORTING

    sortBy = 'CreatedDate';

    sortDirection = 'DESC';


    // DATATABLE COLUMNS

    columns = [

        {
            label: 'Request Number',

            fieldName: 'CaseNumber',

            type: 'button',

            sortable: true,

            typeAttributes: {

                label: {
                    fieldName: 'CaseNumber'
                },

                name: 'view',

                variant: 'base'

            }
        },


        {
            label: 'Subject',

            fieldName: 'Subject',

            sortable: true
        },


        {
            label: 'Account',

            fieldName: 'accountName'
        },


        {
            label: 'Status',

            fieldName: 'Status',

            sortable: true
        },


        {
            label: 'Priority',

            fieldName: 'Priority',

            sortable: true
        },


        {
            label: 'Origin',

            fieldName: 'Origin',

            sortable: true
        },


        {
            label: 'Owner',

            fieldName: 'ownerName'
        }

    ];


    // STATUS OPTIONS

    statusOptions = [

        {
            label: 'All',
            value: 'All'
        },

        {
            label: 'New',
            value: 'New'
        },

        {
            label: 'Working',
            value: 'Working'
        },

        {
            label: 'Escalated',
            value: 'Escalated'
        },

        {
            label: 'Closed',
            value: 'Closed'
        }

    ];


    // PRIORITY OPTIONS

    priorityOptions = [

        {
            label: 'All',
            value: 'All'
        },

        {
            label: 'High',
            value: 'High'
        },

        {
            label: 'Medium',
            value: 'Medium'
        },

        {
            label: 'Low',
            value: 'Low'
        }

    ];


    // ORIGIN OPTIONS

    originOptions = [

        {
            label: 'All',
            value: 'All'
        },

        {
            label: 'Email',
            value: 'Email'
        },

        {
            label: 'Phone',
            value: 'Phone'
        },

        {
            label: 'Web',
            value: 'Web'
        }

    ];


    // GET CASES
@wire(getServiceRequests, {

    searchKey: '$searchKey',

    status: '$status',

    priority: '$priority',

    origin: '$origin',

    sortBy: '$sortBy',

    sortDirection: '$sortDirection',

    pageSize: '$pageSize',

    pageNumber: '$pageNumber'

})

wiredCases(result) {

    this.wiredCasesResult = result;

    const { data, error } = result;

    if (data) {

        this.cases = data.map(caseRecord => {

            return {

                ...caseRecord,

                accountName:
                    caseRecord.Account
                        ? caseRecord.Account.Name
                        : '',

                ownerName:
                    caseRecord.Owner
                        ? caseRecord.Owner.Name
                        : ''

            };

        });

    }

    if (error) {

        console.error(
            'Error loading Cases:',
            error
        );

    }

}


    // GET TOTAL RECORDS

   @wire(getTotalRecords, {

    searchKey: '$searchKey',

    status: '$status',

    priority: '$priority',

    origin: '$origin'

})

wiredTotalRecords(result) {

    this.wiredTotalRecordsResult = result;

    const { data, error } = result;

    if (data !== undefined) {

        this.totalRecords = data;

        this.totalPages = Math.max(

            1,

            Math.ceil(
                this.totalRecords / this.pageSize
            )

        );

    }

    if (error) {

        console.error(
            'Error loading total records:',
            error
        );

    }

}

//Standard Page opening By navigation mixin

handleNewCase() {
    
    this[NavigationMixin.Navigate]({

        type: 'standard__objectPage',

        attributes: {

            objectApiName: 'Case',
             actionName: 'new'

        }

    });

}

// Deleting the Selected case 

handleRowSelection(event) {

    this.selectedRows =event.detail.selectedRows;

}


    // SEARCH

    handleSearch(event) {

        this.searchKey =
            event.target.value;

        this.pageNumber = 1;

    }


    // STATUS FILTER

    handleStatusChange(event) {

        this.status =
            event.detail.value;

        this.pageNumber = 1;

    }


    // PRIORITY FILTER

    handlePriorityChange(event) {

        this.priority =event.detail.value;

        this.pageNumber = 1;

    }


    // ORIGIN FILTER

    handleOriginChange(event) {

        this.origin = event.detail.value;

        this.pageNumber = 1;

    }


    // SORT

    handleSort(event) {

        this.sortBy =
            event.detail.fieldName;

        this.sortDirection =
            event.detail.sortDirection === 'asc'
                ? 'ASC'
                : 'DESC';

        this.pageNumber = 1;

    }


    // OPEN SERVICE REQUEST DETAILS

    handleRowAction(event) {

        const actionName =
            event.detail.action.name;

        const row =
            event.detail.row;


        console.log(
            'Clicked Case Id:',
            row.Id
        );


        if (actionName === 'view') {

            this[NavigationMixin.Navigate]({

                type: 'standard__navItemPage',

                attributes: {

                    apiName: 'casedetails'

                },

                state: {

                    c__recordId: row.Id

                }

            });

        }

    }


    // PREVIOUS

    handlePrevious() {

        if (this.pageNumber > 1) {

            this.pageNumber--;

        }

    }


    // NEXT

    handleNext() {

        if (
            this.pageNumber <
            this.totalPages
        ) {

            this.pageNumber++;

        }

    }


    // GETTERS

    get previousDisabled() {

        return this.pageNumber <= 1;

    }


    get nextDisabled() {

        return this.pageNumber >= this.totalPages;

    }


    get sortDirectionForTable() {

        return this.sortDirection.toLowerCase();

    }

  //getter for controlling delelte button
      get showDeleteButton() {

    return this.selectedRows.length > 0;

}


//handle deletion action
async handleDelete() {

    if (this.selectedRows.length === 0) {

        return;

    }

    const confirmDelete =
        window.confirm(
            'Are you sure you want to delete the selected Case(s)?'
        );

    if (!confirmDelete) {

        return;

    }

    try {

        const deletePromises =
            this.selectedRows.map(row =>
                deleteRecord(row.Id)
            );

        await Promise.all(deletePromises);

        this.dispatchEvent(

            new ShowToastEvent({

                title: 'Success',

                message:
                    'Selected Case(s) deleted successfully',

                variant: 'success'

            })

        );

        // Clear selected rows
        this.selectedRows = [];

        // Refresh Case table
        await refreshApex(
            this.wiredCasesResult
        );

        // Refresh total records
        await refreshApex(
            this.wiredTotalRecordsResult
        );

    } catch (error) {

        console.error(
            'Error deleting Cases:',
            error
        );

        this.dispatchEvent(

            new ShowToastEvent({

                title: 'Error',

                message:
                    'Error deleting Case(s)',

                variant: 'error'

            })

        );

    }

}





}