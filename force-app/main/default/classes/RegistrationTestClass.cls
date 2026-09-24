@isTest
public class RegistrationTestClass{

    @isTest
    static void testRegistrationInsert() {

        // Create Event
        Event__c evt = new Event__c(
            Name = 'Salesforce Workshop',
            Maximum_members_capacity__c = 100,
            AvailableSeat__c = 100
        );
        insert evt;

        Test.startTest();

        // Create Registration
        Registration__c reg = new Registration__c(
           	Name = 'John Doe',
            Email__c = 'john@test.com',
            Associated_event__c = evt.Id,
            Registration_Status__c = 'approve'
        );

        insert reg;

        Test.stopTest();

        Event__c updatedEvent = [
            SELECT Id, AvailableSeat__c
            FROM Event__c
            WHERE Id = :evt.Id
        ];

        System.assertEquals(
            99,
            updatedEvent.AvailableSeat__c,
            'Available seats should decrease by 1'
        );
    }

    @isTest
    static void testRegistrationDelete() {

        Event__c evt = new Event__c(
            Name = 'Developer Meetup',
           Maximum_members_capacity__c = 50,
            AvailableSeat__c = 50
        );
        insert evt;

        Registration__c reg = new Registration__c(
            Name = 'Jane Doe',
            Email__c = 'jane@test.com',
            Associated_event__c = evt.Id,
            Registration_Status__c = 'approve'
        );

        insert reg;

        Test.startTest();

        delete reg;

        Test.stopTest();

        Event__c updatedEvent = [
            SELECT Id, AvailableSeat__c
            FROM Event__c
            WHERE Id = :evt.Id
        ];

        System.assertEquals(
            50,
            updatedEvent.AvailableSeat__c,
            'Available seats should increase after delete'
        );
    }

    @isTest
    static void testAvailableSeatCalculation() {

        Event__c evt = new Event__c(
            Name = 'Dreamforce Event',
           Maximum_members_capacity__c = 10,
            AvailableSeat__c = 10
        );
        insert evt;

        List<Registration__c> regs = new List<Registration__c>();

        for(Integer i = 0; i < 3; i++) {

            regs.add(
                new Registration__c(
                    Name = 'User ' + i,
                    Email__c = 'user'+i+'@test.com',
                    Associated_event__c = evt.Id,
                    Registration_Status__c = 'approve'
                )
            );
        }

        insert regs;

        Event__c updatedEvent = [
            SELECT AvailableSeat__c
            FROM Event__c
            WHERE Id = :evt.Id
        ];

        System.assertEquals(
            7,
            updatedEvent.AvailableSeat__c
        );
    }
}