public class MixedDMLExample {

    public static void createAccount() {

        Account acc = new Account(Name = 'Test Account'+System.now().getTime());
        insert acc;
        createUserAsync();
    }

    @future
    public static void createUserAsync() {

        User u = new User(
            FirstName = 'Test',
            LastName = 'User',
            Alias = 'tuser',
            Email = 'testuser@example.com',
            Username = 'testuser12345@example.com',
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1].Id,
            TimeZoneSidKey = 'Asia/Kolkata',
            LocaleSidKey = 'en_IN',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US'
        );

        insert u;
    }
}