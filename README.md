# Salesforce Code Analysis Pipeline

This repository includes a comprehensive GitHub Actions workflow for automated Salesforce code analysis that runs on every pull request.

## 🚀 Features

- **Comprehensive Analysis**: PMD rules, ESLint for LWC, security scanning, and dependency checks
- **PR Integration**: Automatic analysis on pull requests with detailed commenting
- **Quality Gates**: Blocks PR merges when critical/high severity issues are found  
- **Security Integration**: Results uploaded to GitHub Security tab via SARIF
- **Detailed Reporting**: File-by-file breakdown with severity levels and remediation links

## 📋 Analysis Coverage

### Apex Classes & Triggers
- **PMD Rules**: Best practices, code style, design patterns, performance, security
- **Categories**: Documentation, error handling, complexity analysis, governor limits
- **Security**: Injection vulnerabilities, unsafe operations

### Lightning Web Components  
- **ESLint**: JavaScript code quality and best practices
- **Security**: retire-js for vulnerable dependencies
- **Performance**: Bulkification patterns, efficient DOM manipulation

## 🔄 Workflow Triggers

The analysis runs automatically when:
- Pull requests are opened against `main` or `develop` branches
- Changes are made to:
  - `force-app/**` (any Salesforce metadata)
  - `**/*.cls` (Apex classes)
  - `**/*.trigger` (Apex triggers)
  - `**/*.js` (JavaScript files)
  - `**/*.html` (HTML templates)
  - `**/*.css` (Stylesheets)
  - `sfdx-project.json` (Project configuration)

## 📊 Results & Reporting

### PR Comments
Each analysis generates a detailed comment with:
- **Summary table** showing violation counts by severity
- **File-by-file breakdown** with specific issues and line numbers
- **Severity indicators**: 🔴 High/Critical, 🟡 Medium, 🔵 Low/Info
- **Links to documentation** and remediation resources

### Quality Gates
- **High/Critical Issues**: Block PR merge, require fixes before proceeding
- **Medium Issues**: Allow merge but require review
- **Low/Info Issues**: Informational only, no blocking

### GitHub Integration
- **Security Tab**: SARIF results integrated with GitHub's code scanning
- **Artifacts**: Detailed analysis results saved for 30 days
- **Check Status**: Workflow status visible in PR checks

## 🛠️ Setup Instructions

1. **Add Workflow**: The workflow file is already created at `.github/workflows/salesforce-code-analysis.yml`
2. **Repository Permissions**: Ensure GitHub Actions has permissions for:
   - Contents: read
   - Security events: write  
   - Pull requests: write
   - Checks: write
3. **Branch Protection**: Optionally require the "Salesforce Code Analysis" check to pass before merging

## ⚙️ Configuration

### Severity Thresholds
Current configuration blocks PRs when severity 1-2 issues are found:
- **Severity 1**: Critical/Blocker
- **Severity 2**: Major/High  
- **Severity 3**: Minor/Medium
- **Severity 4-5**: Info/Low

### Analysis Engines
- **PMD**: Apex static analysis
- **ESLint-LWC**: Lightning Web Component analysis
- **retire-js**: JavaScript dependency vulnerability scanning

### Customization
To modify analysis behavior, edit the workflow file:
- **Change severity threshold**: Modify `--severity-threshold` parameter
- **Add custom rules**: Include additional PMD rulesets or ESLint configurations
- **Adjust file patterns**: Update the `paths` section in workflow triggers

## 📚 Additional Resources

- [Salesforce Code Analyzer Documentation](https://forcedotcom.github.io/sfdx-scanner/)
- [PMD Apex Rules](https://pmd.github.io/pmd/pmd_rules_apex.html)
- [ESLint LWC Rules](https://github.com/salesforce/eslint-plugin-lwc)
- [GitHub SARIF Documentation](https://docs.github.com/en/code-security/code-scanning/integrating-with-code-scanning/sarif-support-for-code-scanning)

## 🎯 Best Practices

1. **Review Analysis Results**: Don't bypass quality gates without understanding the implications
2. **Regular Updates**: Keep Salesforce CLI and scanner plugin updated
3. **Custom Rules**: Consider adding org-specific PMD rules for business logic patterns
4. **Documentation**: Use the analysis results to improve code documentation and comments
5. **Team Training**: Ensure team understands the rules and knows how to address common violations

The workflow is now active and will automatically analyze all future pull requests! 🎉
