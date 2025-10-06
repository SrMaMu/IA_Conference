*** Settings ***
Documentation    BBVA E2E Test Suite - Main Test Cases
...              Test cases para validación E2E de componentes BBVA
...              Vinculados a JIRA Issue BBVA-46 y QMetry Test Cases
Library          SeleniumLibrary
Library          Collections
Library          DateTime
Library          OperatingSystem
Library          Screenshot
Library          ../libraries/BBVALibrary.py
Resource         ../resources/bbva_common.robot
Resource         ../resources/bbva_keywords.robot
Variables        ../variables/${ENVIRONMENT}_config.py
Suite Setup      Setup BBVA Test Suite
Suite Teardown   Teardown BBVA Test Suite
Test Setup       Setup BBVA Test Case
Test Teardown    Teardown BBVA Test Case

*** Variables ***
${BROWSER}              chrome
${HEADLESS}             False
${IMPLICIT_WAIT}        10
${EXPLICIT_WAIT}        30
${SCREENSHOT_DIR}       ${CURDIR}/../results/screenshots
${REPORT_DIR}           ${CURDIR}/../results/reports

# Test Case Mapping
${TC_55_FIGMA_NODE}     425:6520
${TC_56_FIGMA_NODE}     378:10502
${TC_57_FIGMA_NODE}     287:1292

*** Test Cases ***
BBVA-TC-55 Dashboard Component Validation
    [Documentation]    Test Case: BBVA-TC-55
    ...                Component: Dashboard
    ...                Figma Node: ${TC_55_FIGMA_NODE}
    ...                Acceptance Criteria: Criterio 1 - Dashboard
    ...                QMetry ID: 5GZ3cZOnswkvGb
    [Tags]    dashboard    component    high-priority    figma-node-${TC_55_FIGMA_NODE}
    
    Log To Console    🏦 Executing BBVA-TC-55: Dashboard Component Validation
    
    # Step 1: Navigate to BBVA Login
    Navigate To BBVA Login Page
    
    # Step 2: Perform Login
    Login To BBVA    ${TEST_USER}    ${TEST_PASSWORD}
    
    # Step 3: Validate Dashboard Components
    Wait For Dashboard To Load
    Validate Dashboard Sections
    
    # Step 4: Verify Cuentas Section
    Verify Cuentas Section Exists
    Verify Cuentas Section Content
    
    # Step 5: Verify Tarjetas Section  
    Verify Tarjetas Section Exists
    Verify Tarjetas Section Content
    
    # Step 6: Verify Inversiones Section
    Verify Inversiones Section Exists
    Verify Inversiones Section Content
    
    # Step 7: Take Evidence Screenshot
    Take Test Evidence Screenshot    BBVA-TC-55-Dashboard
    
    # Step 8: Update QMetry Test Result
    Update QMetry Test Result    BBVA-TC-55    PASSED    Dashboard validation successful
    
    Log To Console    ✅ BBVA-TC-55 completed successfully

BBVA-TC-56 Product Detail Component Validation
    [Documentation]    Test Case: BBVA-TC-56
    ...                Component: Product Detail
    ...                Figma Node: ${TC_56_FIGMA_NODE}
    ...                Acceptance Criteria: Criterio 2 - Product detail
    ...                QMetry ID: EoxvsMNbHO4xMz
    [Tags]    product-detail    component    high-priority    figma-node-${TC_56_FIGMA_NODE}
    
    Log To Console    🏦 Executing BBVA-TC-56: Product Detail Component Validation
    
    # Step 1: Navigate from Dashboard to Product Detail
    Navigate To Product Detail From Dashboard
    
    # Step 2: Validate Product Header Information
    Validate Product Header    Visa Signature    ····9867
    
    # Step 3: Verify Límites y Disponibles Section
    Verify Limites Y Disponibles Section
    Verify Limites Values Display
    
    # Step 4: Verify Total A Pagar Section
    Verify Total A Pagar Section
    Verify Payment Status Message
    
    # Step 5: Verify Opciones de Tarjeta Tabs
    Verify Opciones Tarjeta Tabs
    Verify Consumos Del Mes Tab
    Verify Cuotas Pendientes Tab
    Verify Mas Opciones Tab
    
    # Step 6: Verify Último Resumen Section
    Verify Ultimo Resumen Section
    Verify Resumen Details
    
    # Step 7: Verify Próximo Resumen Section
    Verify Proximo Resumen Section
    
    # Step 8: Take Evidence Screenshot
    Take Test Evidence Screenshot    BBVA-TC-56-Product-Detail
    
    # Step 9: Update QMetry Test Result
    Update QMetry Test Result    BBVA-TC-56    PASSED    Product detail validation successful
    
    Log To Console    ✅ BBVA-TC-56 completed successfully

BBVA-TC-57 Information Detail Component Validation
    [Documentation]    Test Case: BBVA-TC-57
    ...                Component: Information Detail
    ...                Figma Node: ${TC_57_FIGMA_NODE}
    ...                Acceptance Criteria: Criterio 3 - Info Detail
    ...                QMetry ID: mVDMIxEpFNYDR4
    [Tags]    information-detail    component    high-priority    figma-node-${TC_57_FIGMA_NODE}
    
    Log To Console    🏦 Executing BBVA-TC-57: Information Detail Component Validation
    
    # Step 1: Expand Detailed Information
    Click Detalle Limites Y Disponibles Button
    
    # Step 2: Validate Expanded Limit Information
    Validate Limite Total Display
    Verify Limite Total Value    $ 14.000.000,00
    
    # Step 3: Verify Pausar Tarjeta Functionality
    Verify Pausar Tarjeta Switch Exists
    Verify Pausar Tarjeta Switch Functionality
    
    # Step 4: Verify Enhanced Payment Status
    Verify Enhanced Payment Status Display
    Verify Payment Status Actions
    
    # Step 5: Verify Detailed Movimientos Table
    Verify Movimientos Table Headers
    Verify Movimientos Table Structure
    
    # Step 6: Verify Additional Controls
    Verify Adelantar Pago Button
    Verify Stop Debit Buttons
    Verify Descargar Resumen Button
    
    # Step 7: Validate Information Completeness
    Validate All Information Fields Populated
    
    # Step 8: Take Evidence Screenshot
    Take Test Evidence Screenshot    BBVA-TC-57-Information-Detail
    
    # Step 9: Update QMetry Test Result
    Update QMetry Test Result    BBVA-TC-57    PASSED    Information detail validation successful
    
    Log To Console    ✅ BBVA-TC-57 completed successfully

E2E Complete Flow Validation
    [Documentation]    Integrated E2E test that validates the complete flow
    ...                from Dashboard through Product Detail to Information Detail
    ...                This test validates the entire user journey
    [Tags]    e2e    integration    complete-flow    high-priority
    
    Log To Console    🔄 Executing E2E Complete Flow Validation
    
    # Phase 1: Dashboard Validation
    Log To Console    📊 Phase 1: Dashboard Validation
    Execute Dashboard Validation Flow
    
    # Phase 2: Product Selection and Detail
    Log To Console    🎯 Phase 2: Product Detail Navigation
    Execute Product Detail Flow
    
    # Phase 3: Information Detail Exploration
    Log To Console    📋 Phase 3: Information Detail Validation
    Execute Information Detail Flow
    
    # Phase 4: Complete Flow Evidence
    Take Test Evidence Screenshot    E2E-Complete-Flow-Final
    
    # Phase 5: Generate Flow Report
    Generate E2E Flow Report
    
    Log To Console    🎉 E2E Complete Flow validation successful

Multi-Platform Responsive Validation
    [Documentation]    Validates BBVA components across different screen resolutions
    ...                Tests responsive behavior for mobile and desktop viewports
    [Tags]    responsive    multi-platform    cross-browser
    
    Log To Console    📱 Executing Multi-Platform Responsive Validation
    
    FOR    ${viewport}    IN    @{RESPONSIVE_VIEWPORTS}
        Log To Console    🖥️  Testing viewport: ${viewport}
        Set Browser Viewport    ${viewport}
        Execute Responsive Test Suite    ${viewport}
        Take Test Evidence Screenshot    Responsive-${viewport}
    END
    
    Log To Console    ✅ Multi-Platform Responsive validation completed

*** Keywords ***
Setup BBVA Test Suite
    [Documentation]    Configura el entorno de testing para toda la suite
    
    Log To Console    🔧 Setting up BBVA Test Suite
    
    # Create necessary directories
    Create Directory    ${SCREENSHOT_DIR}
    Create Directory    ${REPORT_DIR}
    
    # Set global variables from environment
    Set Global Variable    ${TEST_USER}    ${BBVA_USERS.user1.web_user}
    Set Global Variable    ${TEST_PASSWORD}    ${BBVA_USERS.user1.password}
    Set Global Variable    ${TEST_DNI}    ${BBVA_USERS.user1.dni}
    
    # Configure browser settings
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    --disable-dev-shm-usage
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Call Method    ${chrome_options}    add_argument    --window-size=1920,1080
    
    Run Keyword If    ${HEADLESS}    Call Method    ${chrome_options}    add_argument    --headless
    
    # Open browser with configuration
    Create Webdriver    Chrome    options=${chrome_options}
    Set Window Size    1920    1080
    Set Selenium Implicit Wait    ${IMPLICIT_WAIT}
    
    # Initialize test context
    Initialize Test Context
    
    Log To Console    ✅ BBVA Test Suite setup completed

Teardown BBVA Test Suite
    [Documentation]    Limpia el entorno al finalizar la suite
    
    Log To Console    🧹 Tearing down BBVA Test Suite
    
    # Generate consolidated report
    Generate Consolidated Test Report
    
    # Close browser
    Close All Browsers
    
    # Update JIRA Issue with results
    Update JIRA Issue With Results
    
    Log To Console    ✅ BBVA Test Suite teardown completed

Setup BBVA Test Case
    [Documentation]    Configuración específica antes de cada test case
    
    ${test_name}=    Get Test Name
    Log To Console    🚀 Starting test case: ${test_name}
    
    # Set test-specific variables
    Set Test Variable    ${TEST_START_TIME}    ${EMPTY}
    ${start_time}=    Get Current Date
    Set Test Variable    ${TEST_START_TIME}    ${start_time}

Teardown BBVA Test Case
    [Documentation]    Limpieza específica después de cada test case
    
    ${test_name}=    Get Test Name
    ${test_status}=    Get Test Status
    
    # Calculate test duration
    ${end_time}=    Get Current Date
    ${duration}=    Subtract Date From Date    ${end_time}    ${TEST_START_TIME}
    
    Log To Console    ⏱️  Test ${test_name} completed in ${duration} seconds with status: ${test_status}
    
    # Take screenshot on failure
    Run Keyword If Test Failed    Take Test Evidence Screenshot    ${test_name}-FAILED
    
    # Log test completion
    Log Test Completion    ${test_name}    ${test_status}    ${duration}