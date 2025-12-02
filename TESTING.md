# Testing the Salesforce Code Analysis Workflow

This guide explains how to test the GitHub Actions workflow for Salesforce code analysis.

## 🚀 Quick Test Setup

### Prerequisites
1. Push this repository to GitHub
2. Ensure GitHub Actions is enabled in your repository settings
3. Make sure you have the necessary permissions (Contents: read, Security events: write, Pull requests: write, Checks: write)

### Test Files Created
The following test files contain intentional violations for testing:

#### Apex Files with PMD Violations:
- **`force-app/main/default/classes/AccountService.cls`**
  - Method naming violations (CREATE_ACCOUNT should be camelCase)
  - Empty catch blocks
  - SOQL/DML in loops
  - Unused variables
  - Complex nested if statements
  - Hardcoded string literals
  - Too many method parameters
  - System.debug statements

- **`force-app/main/default/triggers/AccountTrigger.trigger`**
  - Complex trigger logic (should use handler pattern)
  - SOQL in triggers
  - DML in triggers
  - Deep nested conditions
  - Empty code blocks
  - Duplicate code
  - Generic exception handling

#### Lightning Web Component with ESLint Violations:
- **`force-app/main/default/lwc/accountManager/accountManager.js`**
  - Unused variables
  - Missing JSDoc comments
  - Console.log statements
  - Unreachable code
  - Using `var` instead of `let/const`
  - `==` instead of `===`
  - Functions in loops
  - Empty catch blocks
  - Direct DOM manipulation
  - Using `eval()` (security issue)
  - Magic numbers
  - Async/await issues

## 🧪 Testing Steps

### 1. Create a Test Branch and Pull Request
```bash
# Create a new branch
git checkout -b test-code-analysis

# Add a small change to trigger the workflow
echo "# Test commit" >> force-app/main/default/classes/AccountService.cls

# Commit and push
git add .
git commit -m "Test: Trigger code analysis workflow"
git push origin test-code-analysis
```

### 2. Open Pull Request
- Go to your GitHub repository
- Create a pull request from `test-code-analysis` to `main`
- The workflow should automatically trigger

### 3. Expected Results

#### Workflow Should:
- ✅ Install Salesforce CLI and Code Analyzer
- ✅ Run PMD analysis on Apex files
- ✅ Run ESLint analysis on LWC files  
- ✅ Generate SARIF and JSON reports
- ✅ Process results and count violations by severity
- ❌ **FAIL the workflow** due to high/critical severity issues
- ✅ Post detailed comment on PR with:
  - Summary table of violations by severity
  - File-by-file breakdown of issues
  - Links to documentation and remediation resources

#### Expected Violations Count:
- **High/Critical Issues**: 15+ violations (will block PR)
- **Medium Issues**: 8+ violations  
- **Low/Info Issues**: 10+ violations
- **Total**: 30+ violations across all files

### 4. GitHub Security Integration
- Check the **Security** tab in your repository
- Look for **Code scanning alerts**
- SARIF results should be visible with detailed findings

### 5. Artifacts
- Workflow run should generate artifacts named `salesforce-analysis-results`
- Download to see detailed JSON and SARIF reports

## 🔍 What to Verify

### PR Comment Should Include:
- ❌ **"BLOCKING ISSUES FOUND"** header
- 📊 Summary table with violation counts
- 📝 Detailed issues section grouped by file
- 🔴 High/Critical issues marked with red icons
- 🟡 Medium issues marked with yellow icons  
- 🔵 Low/Info issues marked with blue icons
- 🔗 Links to Salesforce Code Analyzer documentation

### Workflow Status Should:
- ❌ Show **failed status** (red X)
- 🚫 Block PR merge due to quality gate failure
- 📋 Display in PR checks section

### Security Tab Should Show:
- 🔒 Code scanning alerts from SARIF upload
- 📊 Security-related violations highlighted
- 📈 Trend analysis if you run multiple times

## 🛠️ Troubleshooting

### If Workflow Doesn't Trigger:
1. Check that files match the `paths` in workflow trigger
2. Verify branch names (`main` or `develop`)
3. Ensure GitHub Actions is enabled

### If No Violations Found:
1. Check that Salesforce CLI installed correctly
2. Verify scanner plugin installation
3. Look at workflow logs for error messages

### If Comment Not Posted:
1. Check repository permissions for GitHub Actions
2. Verify `pull-requests: write` permission is set
3. Check for API rate limiting issues

## 🎯 Testing Different Scenarios

### Test Clean Code (Expected: ✅ Pass)
1. Fix all violations in the files
2. Create new PR - should pass with green checkmark

### Test Medium Severity Only (Expected: ⚠️ Pass with warnings)
1. Fix high/critical issues, leave medium/low
2. Should pass but show warnings in comment

### Test Custom Rules
1. Modify workflow to add custom PMD rulesets
2. Test organization-specific coding standards

The test files provide a comprehensive validation of the code analysis pipeline! 🚀
