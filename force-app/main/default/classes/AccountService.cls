//_______________This Code was generated using GenAI tool: Codify, Please check for accuracy_______________//

/**
 * @description Service class for Account operations
 * @author Codify GenAI
 * @date 2025
 */
public with sharing class AccountService {
    
    /**
     * @description Get accounts by type
     * @param accountType The type of account to filter by
     * @return List of accounts matching the type
     */
    public static List<Account> getAccountsByType(String accountType) {
        try {
            return [
                SELECT Id, Name, Type, Industry, Phone, Website 
                FROM Account 
                WHERE Type = :accountType 
                WITH SECURITY_ENFORCED 
                ORDER BY Name
                LIMIT 100
            ];
        } catch (Exception e) {
            System.debug(LoggingLevel.ERROR, 'Error in getAccountsByType: ' + e.getMessage());
            throw new AuraHandledException('Unable to retrieve accounts: ' + e.getMessage());
        }
    }
    
    /**
     * @description Create new account with validation
     * @param accountName Name of the account
     * @param accountType Type of the account
     * @return Created account record
     */
    public static Account createAccount(String accountName, String accountType) {
        if (String.isBlank(accountName)) {
            throw new IllegalArgumentException('Account name cannot be blank');
        }
        
        Account newAccount = new Account(
            Name = accountName.trim(),
            Type = accountType
        );
        
        try {
            Database.SaveResult result = Database.insert(newAccount, false);
            if (result.isSuccess()) {
                return newAccount;
            } else {
                String errorMessage = result.getErrors()[0].getMessage();
                throw new DmlException('Failed to create account: ' + errorMessage);
            }
        } catch (DmlException e) {
            System.debug(LoggingLevel.ERROR, 'DML Error in createAccount: ' + e.getMessage());
            throw e;
        }
    }
}

//__________________________GenAI: Generated code ends here______________________________//
