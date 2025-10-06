*** Variables ***
# =============================================================================
# BBVA TEST CONFIGURATION VARIABLES
# =============================================================================

# Test Environment Configuration
&{BBVA_ENVIRONMENTS}
...    desa1_qa=&{desa1_qa}
...    desa16_qa=&{desa16_qa}

&{desa1_qa}
...    login_url=https://desa1-qa.bbva.com.ar/fnetcore/login/index.html
...    name=QA Environment 1

&{desa16_qa}
...    login_url=https://desa16-qa.bbva.com.ar/fnetcore/login/index.html
...    name=QA Environment 16 (Fallback)

# Test Credentials (DO NOT COMMIT REAL CREDENTIALS)
${TEST_DNI}                     12345678
${TEST_USERNAME}                testuser
${TEST_PASSWORD}                testpass123

# Browser Configuration
${BROWSER}                      chrome
${HEADLESS}                     False
${BROWSER_OPTIONS}              add_argument("--disable-web-security"); add_argument("--allow-running-insecure-content")
${IMPLICIT_WAIT}                10s
${EXPLICIT_WAIT}                30s

# Viewport Configurations for Responsive Testing
&{VIEWPORT_DESKTOP}
...    width=1920
...    height=1080
...    type=desktop

&{VIEWPORT_TABLET}
...    width=1024
...    height=768
...    type=tablet

&{VIEWPORT_MOBILE}
...    width=375
...    height=667
...    type=mobile

@{RESPONSIVE_VIEWPORTS}         ${VIEWPORT_DESKTOP}    ${VIEWPORT_TABLET}    ${VIEWPORT_MOBILE}

# QMetry Test Case Mappings
&{QMETRY_TEST_CASES}
...    BBVA-TC-55=Dashboard Component Validation
...    BBVA-TC-56=Product Detail Navigation and Display
...    BBVA-TC-57=Information Detail Functionality

# Figma Component Mappings
&{FIGMA_COMPONENTS}
...    425:6520=Dashboard
...    378:10502=Product Detail  
...    287:1292=Information Detail

# Test Data
&{TEST_CARDS}
...    visa=&{visa_card}
...    mastercard=&{mastercard_card}

&{visa_card}
...    type=Visa Signature
...    last_digits=····9867
...    limit_total=$ 14.000.000,00

&{mastercard_card}
...    type=Mastercard Black
...    last_digits=····4126

# Expected Values
${EXPECTED_LIMITE_TOTAL}        $ 14.000.000,00
${EXPECTED_PAYMENT_STATUS}      Estás al día con el pago
${EXPECTED_DASHBOARD_TITLE}     Mis productos | BBVA
${EXPECTED_LOGIN_TITLE}         Te damos la bienvenida a Banca Online | BBVA Argentina
${EXPECTED_TARJETAS_TITLE}      Tarjetas | BBVA

# Directory Paths
${SCREENSHOT_DIR}               ${CURDIR}${/}..${/}..${/}evidencias
${REPORT_DIR}                   ${CURDIR}${/}..${/}..${/}reports
${LOG_DIR}                      ${CURDIR}${/}..${/}..${/}logs

# Test Timing
${ELEMENT_LOAD_TIMEOUT}         15s
${PAGE_LOAD_TIMEOUT}            30s
${ANIMATION_WAIT}               2s
${POPUP_WAIT}                   5s

# JIRA Integration
${JIRA_ISSUE_KEY}               BBVA-46
${JIRA_PROJECT_KEY}             BBVA
@{JIRA_ACCEPTANCE_CRITERIA}
...    Dashboard shows Cuentas, Tarjetas, and Inversiones sections correctly
...    Product detail displays card information and navigation works properly  
...    Information detail shows limits, payment status, and interactive elements

# Error Messages
${ERROR_LOGIN_FAILED}           Login failed - check credentials or environment
${ERROR_PAGE_LOAD}              Page failed to load within expected timeout
${ERROR_ELEMENT_NOT_FOUND}      Required UI element not found on page
${ERROR_NAVIGATION_FAILED}      Navigation between pages failed
${ERROR_RESPONSIVE_MISMATCH}    Responsive layout does not match expected viewport

# Test Tags
@{SMOKE_TESTS}                  smoke    critical    bbva
@{REGRESSION_TESTS}             regression    bbva    e2e
@{RESPONSIVE_TESTS}             responsive    mobile    tablet    desktop
@{INTEGRATION_TESTS}            integration    qmetry    jira    figma

# Browser Specific Settings
&{CHROME_OPTIONS}
...    add_argument=--disable-web-security
...    add_argument=--allow-running-insecure-content
...    add_argument=--disable-features=VizDisplayCompositor
...    add_experimental_option=useAutomationExtension,False
...    add_experimental_option=excludeSwitches,["enable-automation"]

&{FIREFOX_PREFERENCES}
...    security.tls.insecure_fallback_hosts=desa1-qa.bbva.com.ar,desa16-qa.bbva.com.ar
...    security.mixed_content.block_active_content=false

# Test Execution Configuration
${RETRY_ATTEMPTS}               3
${RETRY_DELAY}                  2s
${PARALLEL_EXECUTION}           True
${CAPTURE_SCREENSHOTS}          True
${GENERATE_REPORTS}             True

# QMetry Configuration
${QMETRY_PROJECT_ID}            1
${QMETRY_CYCLE_ID}              10850
${QMETRY_FOLDER_ID}             1

# Performance Thresholds
${MAX_PAGE_LOAD_TIME}           10s
${MAX_ELEMENT_LOAD_TIME}        5s
${MAX_ANIMATION_TIME}           3s