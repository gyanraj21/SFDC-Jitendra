@isTest
public class AccountHandlerTest {
    @isTest
    static void testInsertNewAccount_Success() {
        // Call method to insert account
        Account acc = AccountHandler.insertNewAccount('Test Account');
        
        // Assert that the account is created
        System.assertNotEquals(acc, null, 'Account should not be null');
        System.assertNotEquals(acc.Id, null, 'Account should have an ID');
        
        // Verify the record exists in the database
        Account insertedAcc = [SELECT Id, Name FROM Account WHERE Id = :acc.Id LIMIT 1];
        System.assertEquals('Test Account', insertedAcc.Name, 'Account name should match');
    }

    @isTest
    static void testInsertNewAccount_BlankName() {
        try {
            Account acc = AccountHandler.insertNewAccount('');
            System.assert(false, 'Exception should have been thrown for blank name');
        } catch (IllegalArgumentException e) {
            System.assertEquals('Account name cannot be blank.', e.getMessage());
        }
    }

    @isTest
    static void testInsertNewAccount_DmlException() {
        Test.startTest();
        
        // Create an account with a duplicate unique field (simulate DML failure)
        Account acc = new Account(Name = 'Duplicate Account');
        insert acc;
        
        Test.stopTest();
        
        // Try inserting another account with the same name (assuming a unique constraint exists)
        Account acc2 = AccountHandler.insertNewAccount('Duplicate Account');
        System.assertEquals(null, acc2, 'Should return null due to DML exception');
    }
}