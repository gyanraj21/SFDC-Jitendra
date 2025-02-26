public class AccountHandler {
    public static Account insertNewAccount(String accountName) {
        // Validate input
        if (String.isBlank(accountName)) {
            throw new IllegalArgumentException('Account name cannot be blank.');
        }
        
        Account acc = new Account(Name = accountName);
        try {
            insert acc;
            return acc;
        } catch (DmlException e) {
            System.debug('Error inserting account: ' + e.getMessage());
            return null;
        }
    }
}