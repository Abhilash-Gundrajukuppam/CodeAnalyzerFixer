// LWC component with intentional ESLint violations for testing
// Generated using GenAI tool: Codify - Please review for accuracy
import { LightningElement, track, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getAccounts from '@salesforce/apex/AccountService.processAccounts';

export default class AccountManager extends LightningElement {
    
    // ESLint Violation: Unused variable
    unusedProperty = 'This property is never used';
    
    @track accounts = [];
    
    // ESLint Violation: Missing JSDoc comment
    connectedCallback() {
        // ESLint Violation: console.log should not be used in production
        console.log('Component connected');
        
        // ESLint Violation: Unreachable code after return
        this.loadAccounts();
        return;
        this.accounts = []; // This line is unreachable
    }
    
    // ESLint Violation: Function complexity too high
    loadAccounts() {
        // ESLint Violation: var instead of let/const
        var self = this;
        
        // ESLint Violation: == instead of ===
        if(this.accounts == null) {
            // ESLint Violation: Nested function calls
            getAccounts()
                .then(function(result) {
                    // ESLint Violation: Function inside loop
                    for(var i = 0; i < result.length; i++) {
                        setTimeout(function() {
                            console.log('Processing account: ' + result[i].Name);
                        }, 100);
                    }
                    
                    self.accounts = result;
                    
                    // ESLint Violation: Multiple nested callbacks
                    if(result.length > 0) {
                        if(result[0].Name) {
                            if(result[0].Name.length > 0) {
                                self.showToast('Success', 'Accounts loaded', 'success');
                            }
                        }
                    }
                })
                .catch(function(error) {
                    // ESLint Violation: Empty catch block
                });
        }
    }
    
    // ESLint Violation: Missing parameter validation
    handleAccountClick(event) {
        // ESLint Violation: Modifying event object
        event.currentTarget.dataset.selected = true;
        
        // ESLint Violation: Direct DOM manipulation instead of using template
        let element = this.template.querySelector('.account-item');
        element.style.backgroundColor = '#ff0000';
        
        // ESLint Violation: Using eval (security issue)
        var accountId = eval('event.currentTarget.dataset.accountId');
        
        // ESLint Violation: Alert in LWC (should use toast)
        alert('Account selected: ' + accountId);
    }
    
    // ESLint Violation: Function name not descriptive
    doStuff() {
        // ESLint Violation: Magic numbers without constants
        let randomValue = Math.random() * 100;
        
        // ESLint Violation: Unnecessary string concatenation
        let message = 'Random value is: ' + randomValue + '';
        
        // ESLint Violation: Unused assignment
        message = 'This will not be used';
        
        // ESLint Violation: Missing return statement
    }
    
    showToast(title, message, variant) {
        // ESLint Violation: Creating object in method instead of outside
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });
        this.dispatchEvent(event);
    }
    
    // ESLint Violation: Async function not properly handling promises
    async updateAccount(accountId) {
        // ESLint Violation: Not using await for async operation
        getAccounts({ accountId: accountId });
        
        // ESLint Violation: Promise not handled
        fetch('/services/data/v59.0/sobjects/Account/' + accountId)
            .then(response => response.json());
    }
    
    // ESLint Violation: Getter with side effects
    get accountCount() {
        console.log('Getting account count'); // Side effect in getter
        this.loadAccounts(); // Side effect in getter
        return this.accounts.length;
    }
}
