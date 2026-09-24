public class AccountHandler {

    public static Account insertNewAccount(String acctName) {

        try {
            Account acc = new Account();
            acc.Name = acctName;

            insert acc;

            return acc;

        } catch (DmlException e){
            
            System.debug('ERROR = ' + e.getMessage());
            return null;
        }
    }
}