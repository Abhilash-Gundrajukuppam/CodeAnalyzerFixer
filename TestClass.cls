//_______________This Code was generated using GenAI tool: Codify, Please check for accuracy_______________//

public class TestClass {
    
    // Issue 1: Missing sharing keyword (should be 'with sharing' or 'without sharing')
    
    public static void processAccounts() {
        // Issue 2: SOQL query in a loop
        for(Integer i = 0; i < 10; i++) {
            List<Account> accounts = [SELECT Id, Name FROM Account LIMIT 1];
        }
        
        // Issue 3: DML operation in a loop
        for(Integer j = 0; j < 5; j++) {
            Account acc = new Account(Name = 'Test Account ' + j);
            insert acc; // DML in loop
        }
    }
    
    public static void updateContactsWithHardcodedId() {
        // Issue 4: Hardcoded ID
        String hardcodedAccountId = '001000000000000AAA';
        
        // Issue 5: Missing null check and potential NPE
        List<Contact> contacts = [SELECT Id, AccountId FROM Contact WHERE AccountId = :hardcodedAccountId];
        for(Contact c : contacts) {
            c.LastName.toUpperCase(); // Potential NPE if LastName is null
            c.Email.substring(0, 5); // Potential NPE and IndexOutOfBounds
        }
        
        // Issue 6: DML without try-catch
        update contacts;
    }
    
    public static void inefficientBulkProcessing(List<Id> accountIds) {
        // Issue 7: SOQL in loop for bulk processing
        List<Account> accountsToUpdate = new List<Account>();
        
        for(Id accId : accountIds) {
            // SOQL in loop - should query all at once
            Account acc = [SELECT Id, Name, Industry FROM Account WHERE Id = :accId];
            
            if(acc != null) {
                acc.Industry = 'Technology';
                accountsToUpdate.add(acc);
            }
            
            // Issue 8: Nested SOQL queries
            List<Contact> relatedContacts = [SELECT Id FROM Contact WHERE AccountId = :accId];
            for(Contact con : relatedContacts) {
                // Another SOQL in nested loop
                List<Case> cases = [SELECT Id FROM Case WHERE ContactId = :con.Id];
            }
        }
        
        update accountsToUpdate;
    }
    
    // Issue 9: Method with too many SOQL queries (governor limit risk)
    public static void tooManyQueries() {
        for(Integer i = 0; i < 150; i++) {
            List<Account> acc = [SELECT Id FROM Account LIMIT 1];
        }
    }
    
    // Issue 10: Missing field-level security check
    public static List<Account> getAccountData() {
        // Should check Schema.sObjectType.Account.fields.Revenue.isAccessible()
        return [SELECT Id, Name, AnnualRevenue, Industry FROM Account LIMIT 100];
    }
    
    // Issue 11: Inefficient collection handling
    public static void inefficientCollectionHandling() {
        List<String> largeList = new List<String>();
        
        // Memory inefficient - adding to list in loop without size check
        for(Integer i = 0; i < 10000; i++) {
            largeList.add('Item ' + i);
        }
        
        // Inefficient string concatenation
        String result = '';
        for(String item : largeList) {
            result += item + ', '; // Should use StringBuilder equivalent
        }
    }
    
    // Issue 12: Missing exception handling
    public static void riskyDatabaseOperations() {
        Account acc = new Account();
        // Missing required fields - will cause DML exception
        insert acc;
        
        // Risky type casting without checks
        Object obj = 'test';
        Integer num = (Integer)obj; // ClassCastException
    }
    
    // Issue 13: Potential infinite loop
    public static void potentialInfiniteLoop() {
        Integer counter = 0;
        while(counter < 10) {
            // Forgot to increment counter - infinite loop
            System.debug('Processing: ' + counter);
        }
    }
    
    // Issue 14: Inefficient SOQL with unnecessary fields
    public static void inefficientSOQL() {
        // Selecting all fields unnecessarily
        List<Account> accounts = [SELECT FIELDS(ALL) FROM Account];
        
        // Using inefficient LIKE query
        List<Contact> contacts = [SELECT Id FROM Contact WHERE Name LIKE '%test%'];
    }
    
    // Issue 15: Missing input validation
    public static void processUserInput(String userInput) {
        // No input validation - could cause issues
        String query = 'SELECT Id FROM Account WHERE Name = \'' + userInput + '\'';
        // Dynamic SOQL without proper escaping (SOQL injection risk)
        List<Account> accounts = Database.query(query);
    }
}

//__________________________GenAI: Generated code ends here______________________________//
