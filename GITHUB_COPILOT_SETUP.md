# GitHub Copilot Business Integration Setup Guide

## Overview
The workflow now includes proper GitHub Copilot Business integration for automated code fixing. This guide will help you set up the necessary authentication and permissions.

## Prerequisites
- GitHub Copilot Business license for your organization
- Repository admin access
- Organization admin access (for some configurations)

## Setup Steps

### 1. Verify GitHub Copilot Business Access

First, confirm your organization has GitHub Copilot Business:

```bash
# Check if you have access to Copilot
gh copilot status
```

Or check in GitHub:
- Go to your organization settings
- Navigate to "Copilot" section
- Verify "GitHub Copilot Business" is enabled

### 2. Repository Configuration

#### A. Required Repository Settings

1. **Enable GitHub Actions**:
   - Go to repository Settings → Actions → General
   - Ensure "Allow all actions and reusable workflows" is selected

2. **Set Required Permissions**:
   - Go to Settings → Actions → General → Workflow permissions
   - Select "Read and write permissions"
   - Check "Allow GitHub Actions to create and approve pull requests"

#### B. Configure Repository Variables (Optional)

Go to Settings → Secrets and Variables → Actions → Variables tab:

| Variable Name | Default Value | Description |
|---------------|---------------|-------------|
| `LLM_PROVIDER` | `github-copilot` | LLM provider to use |
| `AUTO_FIX_ENABLED` | `true` | Enable automatic fixing |
| `MAX_FIXES_PER_RUN` | `10` | Maximum fixes per workflow run |
| `FIX_SEVERITY_THRESHOLD` | `3` | Fix issues with severity ≤ this value |

### 3. Authentication Setup

The workflow uses the default `GITHUB_TOKEN` which should automatically have access to Copilot for Business accounts. However, if you encounter authentication issues:

#### Option A: Enhanced Token (Recommended for Advanced Features)

1. **Create a Personal Access Token**:
   - Go to GitHub → Settings → Developer settings → Personal access tokens
   - Generate new token (classic) with these scopes:
     - `repo` (Full control of private repositories)
     - `read:org` (Read org and team membership)
     - `copilot` (Access to Copilot features, if available)

2. **Add as Repository Secret**:
   - Repository Settings → Secrets and Variables → Actions
   - Add new repository secret: `COPILOT_API_KEY`
   - Paste your personal access token

#### Option B: GitHub App (Enterprise Setup)

For larger organizations, consider creating a GitHub App:

1. **Create GitHub App**:
   - Organization Settings → Developer settings → GitHub Apps
   - Create new app with permissions:
     - Repository permissions: Contents (Write), Metadata (Read), Pull requests (Write)
     - Organization permissions: Copilot (Read/Write, if available)

2. **Install App**: Install the app on your organization/repository

3. **Configure Authentication**: Use app ID and private key in workflow

### 4. Workflow Features

The updated workflow now includes:

#### A. Enhanced GitHub Copilot Integration
- **API-First Approach**: Attempts to use GitHub Copilot API when available
- **Fallback to Rule-Based Fixes**: Basic fixes for common Salesforce issues
- **Smart Fix Selection**: Prioritizes fixes by severity and impact
- **Code Suggestion Comments**: Creates PR comments when direct fixes aren't possible

#### B. Supported Fix Types
- **ApexSharingViolations**: Adds sharing declarations
- **ApexDoc**: Generates basic documentation comments
- **UnusedLocalVariable**: Comments out unused variables
- **OperationWithLimitsInLoop**: Suggests bulkification improvements
- **And more**: Expandable rule-based fixing system

#### C. Safety Features
- **Backup Creation**: Original files are backed up before fixing
- **Validation**: Re-runs analysis after fixes to verify improvements
- **Manual Review**: All fixes require manual review before merging

### 5. Testing the Setup

#### A. Test with a Simple PR

1. **Create a test branch**:
   ```bash
   git checkout -b test-copilot-integration
   ```

2. **Make a small change** to TestClass.cls (e.g., add a simple method with issues)

3. **Create a Pull Request** targeting `main` or `development`

4. **Monitor the workflow**:
   - Go to Actions tab in your repository
   - Watch the "Salesforce Code Analysis with Auto-Fix" workflow
   - Check the logs for Copilot integration status

#### B. Expected Workflow Behavior

1. **Analysis Phase**: Detects code quality issues
2. **Auto-Fix Phase**: 
   - Attempts Copilot API fixes first
   - Falls back to rule-based fixes
   - Creates suggestion comments for complex issues
3. **Validation Phase**: Re-analyzes code to verify improvements
4. **Commit Phase**: Commits fixed files (if any changes were made)

### 6. Troubleshooting

#### Common Issues and Solutions

**Issue**: "Copilot API not available"
- **Solution**: This is normal - the workflow falls back to rule-based fixes
- **Note**: Direct Copilot API access may be limited based on your license

**Issue**: "GitHub CLI authentication failed"
- **Solution**: 
  - Verify repository has proper permissions
  - Check if `GITHUB_TOKEN` has required scopes
  - Consider adding `COPILOT_API_KEY` secret

**Issue**: "No fixes applied"
- **Solution**: 
  - Check if issues are within severity threshold
  - Verify `AUTO_FIX_ENABLED` is `true`
  - Review fix logs in workflow artifacts

**Issue**: Fixes not committed
- **Solution**:
  - Ensure repository has "Read and write permissions"
  - Check that generated fixes are actually different from originals
  - Review git configuration in workflow logs

### 7. Advanced Configuration

#### A. Custom Fix Rules

You can extend the basic fix functionality by modifying the `apply_basic_fixes` function in the workflow:

```python
def apply_basic_fixes(file_content, rule_name):
    # Add your custom fix logic here
    if "YourCustomRule" in rule_name:
        # Implement custom fix
        pass
    return fixed_content
```

#### B. Integration with Other Tools

The workflow can be extended to work with:
- **SonarQube**: Add SonarQube analysis steps
- **CodeClimate**: Integrate CodeClimate quality checks  
- **Custom Linters**: Add organization-specific code quality tools

#### C. Notification Setup

Add notifications for fix results:
- **Slack Integration**: Notify teams of auto-fix results
- **Email Alerts**: Send summaries to code owners
- **Teams Integration**: Post updates to Microsoft Teams

### 8. Monitoring and Analytics

#### A. Workflow Metrics

Monitor these key metrics:
- **Fix Success Rate**: Percentage of issues successfully fixed
- **Copilot API Usage**: Track API calls and success rates
- **Manual Review Time**: Time from auto-fix to approval
- **Code Quality Improvement**: Before/after issue counts

#### B. Available Logs

The workflow provides detailed logging:
- **Analysis Results**: SARIF and JSON reports
- **Fix Attempts**: Success/failure for each fix
- **Validation Results**: Before/after comparison
- **API Interactions**: Copilot API call results

### 9. Security Considerations

#### A. Code Review Requirements
- **Never auto-merge**: Always require manual review of auto-fixed code
- **Test Coverage**: Ensure tests validate fixed code behavior
- **Security Review**: Review fixes that touch security-sensitive code

#### B. Access Control
- **Limited Permissions**: Use minimal required permissions for tokens
- **Audit Logging**: Monitor who approves auto-fixed changes
- **Branch Protection**: Require reviews even for auto-fixes

### 10. Getting Help

#### A. Resources
- **GitHub Copilot Documentation**: https://docs.github.com/en/copilot
- **Salesforce Code Analyzer**: https://forcedotcom.github.io/sfdx-scanner/
- **PMD Rules Reference**: https://pmd.github.io/pmd/pmd_rules_apex.html

#### B. Support Channels
- **GitHub Support**: For Copilot Business licensing issues
- **Community Forums**: For integration questions
- **Internal Team**: For organization-specific configurations

---

## Quick Start Checklist

- [ ] Verify GitHub Copilot Business access
- [ ] Enable GitHub Actions with write permissions
- [ ] Configure repository variables (optional)
- [ ] Set up authentication (COPILOT_API_KEY if needed)
- [ ] Test with a sample PR
- [ ] Monitor workflow execution
- [ ] Review and approve auto-fixes
- [ ] Set up monitoring and notifications

The workflow is now ready to provide automated code fixes using GitHub Copilot Business integration!
