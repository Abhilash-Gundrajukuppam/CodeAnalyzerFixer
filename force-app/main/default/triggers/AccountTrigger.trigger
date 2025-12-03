// Apex Trigger with intentional PMD violations for testing
// Generated using GenAI tool: Codify - Please review for accuracy
trigger AccountTrigger on Account (before insert, before update, after insert, after update, before delete, after delete, after undelete) {
    
    // PMD Violation: Trigger should delegate to handler class
    // PMD Violation: Too complex trigger logic
    // PMD Violation: Multiple trigger events in one trigger
    
    if(Trigger.isBefore && Trigger.isInsert) {
        // PMD Violation: SOQL in trigger
        List<Account> existingAccounts = [SELECT Id, Name FROM Account WHERE Name LIKE '%Test%'];
        
        for(Account acc : Trigger.new) {
            // PMD Violation: Hardcoded string literals
            if(acc.Name == 'Bad Account Name') {
                acc.Name.addError('Invalid account name');
            }
            
            // PMD Violation: Empty if statement
            if(acc.Type != null) {
                // No action taken
            }
            
            // PMD Violation: Nested if statements too deep
            if(acc.AnnualRevenue != null) {
                if(acc.AnnualRevenue > 1000000) {
                    if(acc.Industry != null) {
                        if(acc.Industry == 'Technology') {
                            if(acc.NumberOfEmployees != null) {
                                if(acc.NumberOfEmployees > 100) {
                                    acc.Rating = 'Hot';
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    if(Trigger.isBefore && Trigger.isUpdate) {
        // PMD Violation: Duplicate code from above
        for(Account acc : Trigger.new) {
            if(acc.Name == 'Bad Account Name') {
                acc.Name.addError('Invalid account name');
            }
        }
        
        // PMD Violation: Variable declared but never used
        Integer unusedCounter = 0;
        
        // PMD Violation: System.debug statements
        System.debug('Processing before update trigger');
        System.debug('Number of records: ' + Trigger.new.size());
    }
    
    if(Trigger.isAfter && Trigger.isInsert) {
        // PMD Violation: DML in trigger instead of using future/queueable
        List<Contact> contactsToInsert = new List<Contact>();
        
        for(Account acc : Trigger.new) {
            // PMD Violation: SOQL in loop
            List<Contact> existingContacts = [SELECT Id FROM Contact WHERE AccountId = :acc.Id];
            
            if(existingContacts.isEmpty()) {
                Contact newContact = new Contact();
                newContact.FirstName = 'Auto';
                newContact.LastName = 'Generated';
                newContact.AccountId = acc.Id;
                contactsToInsert.add(newContact);
            }
        }
        
        // PMD Violation: DML operation in trigger
        if(!contactsToInsert.isEmpty()) {
            insert contactsToInsert;
        }
    }
    
    if(Trigger.isAfter && Trigger.isUpdate) {
        // PMD Violation: Governor limit risk - not checking collection size
        for(Account acc : Trigger.new) {
            // PMD Violation: Calling callout in trigger (if this were a callout)
            // This would violate callout rules
            
            Account oldAcc = Trigger.oldMap.get(acc.Id);
            
            // PMD Violation: Complex boolean expressions
            if((acc.Name != oldAcc.Name && acc.Type != oldAcc.Type) || 
               (acc.Industry != oldAcc.Industry && acc.AnnualRevenue != oldAcc.AnnualRevenue) ||
               (acc.Phone != oldAcc.Phone && acc.Website != oldAcc.Website)) {
                
                // PMD Violation: Empty block
            }
        }
    }
    
    if(Trigger.isBefore && Trigger.isDelete) {
        // PMD Violation: Prevent deletion without proper validation
        for(Account acc : Trigger.old) {
            // PMD Violation: Hardcoded error messages
            acc.addError('Cannot delete this account - custom validation');
        }
    }
    
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete)) {
        // PMD Violation: Catch-all exception handling
        try {
            // PMD Violation: Static method call that should be instance method
            AccountTriggerHelper.processAccounts(Trigger.new);
        } catch (Exception e) {
            // PMD Violation: Generic exception catching
            // PMD Violation: Not logging the actual error
            System.debug('An error occurred');
        }
    }
}

// PMD Violation: Helper class should be in separate file
public class AccountTriggerHelper {
    // PMD Violation: Static method when it could be instance
    public static void processAccounts(List<Account> accounts) {
        // PMD Violation: Method doing too many things
        
        if(accounts != null && accounts.size() > 0) {
            // PMD Violation: Unused local variable
            String processingStatus = 'Started';
            
            for(Account acc : accounts) {
                // PMD Violation: Empty loop body
            }
            
            // PMD Violation: Dead code - variable assigned but never read
            processingStatus = 'Completed';
        }
    }
}
