# BBVA E2E Testing Framework 🏦

[![BBVA E2E Tests](https://github.com/SrMaMu/IA_Conference/actions/workflows/bbva-e2e-testing.yml/badge.svg)](https://github.com/SrMaMu/IA_Conference/actions/workflows/bbva-e2e-testing.yml)

## Overview

Complete End-to-End testing framework for BBVA banking application with integrated JIRA, QMetry, and Figma Desktop validation.

## 🚀 Features

- **Multi-Platform Testing**: Web Desktop, Web Responsive, Mobile Native
- **Robot Framework**: Comprehensive test automation with custom keywords
- **JIRA Integration**: Automated ticket management and tracking
- **QMetry Integration**: Test case execution and reporting
- **Figma Desktop**: Component validation and pixel-perfect testing
- **GitHub Actions**: Automated CI/CD pipeline
- **PowerShell Automation**: Complete test orchestration script

## 📁 Project Structure

```
IA_Conference_2025/
├── tests/robot/                           # Robot Framework Test Suite
│   ├── bbva_e2e_tests.robot             # Main test cases (TC-55, TC-56, TC-57)
│   ├── libraries/
│   │   ├── BBVALibrary.py                # Custom Python library
│   │   └── __init__.py
│   ├── resources/
│   │   ├── bbva_keywords.robot           # Reusable keywords
│   │   └── bbva_variables.robot          # Configuration variables
│   └── requirements.txt                   # Python dependencies
├── .github/workflows/
│   └── bbva-e2e-testing.yml             # CI/CD Pipeline
├── Scripts/
│   └── Start-BBVA-E2E-Automation.ps1    # PowerShell orchestration
└── evidencias/                           # Test evidence and screenshots
```

## 🧪 Test Cases

| Test ID | Description | Figma Node | Status |
|---------|-------------|------------|--------|
| BBVA-TC-55 | Dashboard Component Validation | 425:6520 | ✅ Ready |
| BBVA-TC-56 | Product Detail Navigation | 378:10502 | ✅ Ready |
| BBVA-TC-57 | Information Detail Functionality | 287:1292 | ✅ Ready |

## 🔧 Setup and Installation

### Prerequisites
- Python 3.8+
- Node.js 16+
- Robot Framework
- Chrome/Firefox browsers
- Git

### Installation
```bash
# Clone repository
git clone https://github.com/SrMaMu/IA_Conference.git
cd IA_Conference

# Install Python dependencies
pip install -r tests/robot/requirements.txt

# Install Robot Framework dependencies
pip install robotframework robotframework-seleniumlibrary
```

## 🚀 Execution

### Local Execution
```bash
# Run complete test suite
robot tests/robot/bbva_e2e_tests.robot

# Run specific test case
robot -t "BBVA-TC-55*" tests/robot/bbva_e2e_tests.robot

# Run with specific browser
robot -v BROWSER:firefox tests/robot/bbva_e2e_tests.robot
```

### PowerShell Automation
```powershell
# Run complete E2E automation
.\Scripts\Start-BBVA-E2E-Automation.ps1

# Run with specific environment
.\Scripts\Start-BBVA-E2E-Automation.ps1 -Environment desa16-qa
```

### GitHub Actions
The CI/CD pipeline runs automatically on:
- Push to `main` branch
- Pull requests
- Manual workflow dispatch

## 🎯 Supported Environments

| Environment | URL | Description |
|-------------|-----|-------------|
| QA Primary | https://desa1-qa.bbva.com.ar | Main QA environment |
| QA Fallback | https://desa16-qa.bbva.com.ar | Backup QA environment |

## 📊 Integrations

### JIRA Integration
- Automated ticket management (BBVA-46)
- Test execution tracking
- Acceptance criteria validation

### QMetry Integration
- Test case execution (Issue ID: 10850)
- Result reporting and analytics
- Test cycle management

### Figma Desktop Integration
- Component validation
- Pixel-perfect testing
- Design system compliance

## 🌐 Multi-Platform Support

| Platform | Resolution | Browser Support |
|----------|------------|-----------------|
| Desktop | 1920x1080 | Chrome, Firefox, Edge |
| Tablet | 1024x768 | Chrome, Firefox |
| Mobile | 375x667 | Chrome Mobile |

## 📈 Reporting

### Generated Reports
- Robot Framework HTML reports
- Screenshot evidence
- Test execution logs
- Performance metrics

### Report Locations
- `reports/` - HTML test reports
- `evidencias/` - Screenshot evidence
- `logs/` - Execution logs

## 🔐 Configuration

### Environment Variables
```bash
# JIRA Configuration
JIRA_BASE_URL=https://neo-qa.atlassian.net
JIRA_EMAIL=your.email@example.com
JIRA_TOKEN=your_jira_token

# QMetry Configuration  
QMETRY_PROJECT_ID=1
QMETRY_CYCLE_ID=10850

# Test Credentials (DO NOT COMMIT)
TEST_DNI=12345678
TEST_USERNAME=testuser
TEST_PASSWORD=testpass123
```

## 🎨 Custom Keywords

### BBVA Keywords Library
```robot
*** Keywords ***
Navigate To BBVA Login Page
Login To BBVA
    [Arguments]    ${username}    ${password}    ${dni}
Wait For Dashboard To Load
Execute Dashboard Validation Flow
Execute Product Detail Flow
Execute Information Detail Flow
Take Test Evidence Screenshot
    [Arguments]    ${screenshot_name}
```

### Custom Python Library
```python
from tests.robot.libraries.BBVALibrary import BBVALibrary

# Usage in Robot Framework
Library    tests.robot.libraries.BBVALibrary
```

## 🚨 Troubleshooting

### Common Issues
1. **Login Failed**: Check environment availability (desa1-qa vs desa16-qa)
2. **CICS Selection**: Ensure CICS 7 is selected before login
3. **Element Not Found**: Verify page load completion
4. **Screenshot Issues**: Check screenshot directory permissions

### Environment Fallback
The framework automatically switches from `desa1-qa` to `desa16-qa` if primary environment fails.

## 📝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Support

For questions and support:
- Create an issue in GitHub
- Contact: matias.munoz@neoris.io
- JIRA Project: [BBVA](https://neo-qa.atlassian.net/projects/BBVA)

## 🎯 Roadmap

- [ ] API Testing Integration
- [ ] Performance Testing with K6
- [ ] Visual Regression Testing
- [ ] Mobile App Native Testing
- [ ] Docker Container Support
- [ ] SonarQube Integration
- [ ] Allure Reporting

---

**Built with ❤️ for BBVA by NEORIS AI Conference Team**