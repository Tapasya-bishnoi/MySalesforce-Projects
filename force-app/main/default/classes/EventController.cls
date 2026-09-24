public with sharing class EventController{

    @AuraEnabled
    public static Id createEvent(
        String eventName,
        Date eventDate
    ){

        // Current Logged-in User
        User ui = [

            SELECT Id, Profile.Name
            FROM User
            WHERE Id = :UserInfo.getUserId()

        ];

        // Profile Check
        if (ui.Profile.Name != 'Event Organizer') {

            throw new AuraHandledException(
                'Only Event Organizers can create events.'
            );

        }

        // Create Event Record
        Event__c e = new Event__c();

        e.Name = eventName;
        e.Event_Date__c = eventDate;

        // Check API Name of field before using

        // Assign Owner
        e.OwnerId = UserInfo.getUserId();

        // Insert Record
        insert e;

        // Return Id
        return e.Id;

    }
    












}