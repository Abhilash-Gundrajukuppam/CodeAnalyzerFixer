// This Apex class contains intentional PMD violations for testing
// Generated using GenAI tool: Codify - Please review for accuracy
public class AccountService {
    
    // PMD Violation: Method name should be camelCase
    public static void CREATE_ACCOUNT(String accountName) {
        // PMD Violation: Empty catch block
        try {
            // PMD Violation: SOQL in loop (if this were in a loop)
            Account acc = new Account();
            acc.Name = accountName;
            
            // PMD Violation: DML in loop (if this were in a loop) 
            insert acc;
            
            // PMD Violation: Unused local variable
            String unusedVariable = 'This is not used';
            
        } catch (Exception e) {
            // PMD Violation: Empty catch block - no handling
        }
    }
    
    // PMD Violation: Method too long and complex
    public static List<Account> processAccounts(List<Account> accounts) {
        List<Account> results = new List<Account>();
        
        // PMD Violation: Avoid deeply nested if statements
        for(Account acc : accounts) {
            if(acc.Name != null) {
                if(acc.Name.length() > 0) {
                    if(acc.Type != null) {
                        if(acc.Type == 'Customer') {
                            if(acc.AnnualRevenue != null) {
                                if(acc.AnnualRevenue > 100000) {
                                    // PMD Violation: SOQL in loop
                                    List<Contact> contacts = [SELECT Id FROM Contact WHERE AccountId = :acc.Id];
                                    
                                    acc.Description = 'High value customer with ' + contacts.size() + ' contacts';
                                    results.add(acc);
                                }
                            }
                        }
                    }
                }
            }
        }
        
        // PMD Violation: DML in loop potential
        for(Account acc : results) {
            // This could be in a loop causing DML issues
            update acc;
        }
        
        return results;
    }
    
    // PMD Violation: Hardcoded string literal should be constant
    public static void updateAccountType() {
        List<Account> accounts = [SELECT Id, Type FROM Account WHERE Type = 'Prospect'];
        
        for(Account acc : accounts) {
            acc.Type = 'Customer'; // Should be a constant
        }
        
        update accounts;
    }
    
    // PMD Violation: Method with too many parameters
    public static Account createComplexAccount(String name, String type, String industry, 
                                             String phone, String website, String billingCity,
                                             String billingState, String billingCountry,
                                             Decimal annualRevenue, Integer numberOfEmployees,
                                             String description, String rating) {
        
        Account acc = new Account();
        acc.Name = name;
        acc.Type = type;
        acc.Industry = industry;
        acc.Phone = phone;
        acc.Website = website;
        acc.BillingCity = billingCity;
        acc.BillingState = billingState;
        acc.BillingCountry = billingCountry;
        acc.AnnualRevenue = annualRevenue;
        acc.NumberOfEmployees = numberOfEmployees;
        acc.Description = description;
        acc.Rating = rating;
        
        insert acc;
        return acc;
    }
    
    // PMD Violation: Debugging statements should be removed
    public static void debugMethod() {
        System.debug('This debug statement should be removed before deployment');
        System.debug(LoggingLevel.ERROR, 'Another debug statement');
    }
}
