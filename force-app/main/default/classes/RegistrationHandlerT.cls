public class RegistrationHandlerT{

    public static void updateAvailableSeats(Set<Id> eventsId) {

        List<Event__c> eventsToUpdate = new List<Event__c>();

        for(Event__c evt : [
            SELECT Id,  Maximum_members_capacity__c
            FROM Event__c
            WHERE Id IN :eventsId
        ]) {

            Integer registrationCount = [
                SELECT COUNT()
                FROM Registration__c
                WHERE Associated_event__c = :evt.Id
            ];

            Event__c updateEvent = new Event__c(
                Id = evt.Id,
                AvailableSeat__c = evt.Maximum_members_capacity__c - registrationCount
            );

            eventsToUpdate.add(updateEvent);
        }

        if(!eventsToUpdate.isEmpty()) {
            update eventsToUpdate;
        }
    }
}