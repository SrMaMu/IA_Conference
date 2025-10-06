*** Settings ***
Documentation    BBVA Keywords Library
...              Keywords reutilizables para automatización BBVA
Library          SeleniumLibrary
Library          Collections
Library          String
Library          DateTime
Library          ../libraries/BBVALibrary.py

*** Variables ***
# BBVA Page Locators
${LOGIN_PAGE_TITLE}             Te damos la bienvenida a Banca Online | BBVA Argentina
${DASHBOARD_PAGE_TITLE}         Mis productos | BBVA
${TARJETAS_PAGE_TITLE}          Tarjetas | BBVA

# Login Page Elements
${LOGIN_DNI_INPUT}              id:documentNumber
${LOGIN_USER_INPUT}             id:user
${LOGIN_PASSWORD_INPUT}         id:password
${LOGIN_SUBMIT_BUTTON}          xpath://button[contains(text(),'Ingresar')]
${LOGIN_CICS_SELECTOR}          xpath://button[contains(text(),'CICS7')]

# Dashboard Elements
${DASHBOARD_CUENTAS_SECTION}    xpath://h2[contains(text(),'Cuentas')]
${DASHBOARD_TARJETAS_SECTION}   xpath://h2[contains(text(),'Tarjetas')]
${DASHBOARD_INVERSIONES_SECTION} xpath://h2[contains(text(),'Inversiones')]
${VISA_CARD_BUTTON}             xpath://button[contains(.,'Visa Signature') and contains(.,'9867')]
${MASTERCARD_BUTTON}            xpath://button[contains(.,'Mastercard Black') and contains(.,'4126')]

# Product Detail Elements
${PRODUCT_HEADER}               xpath://h2[contains(text(),'Visa Signature terminada en ····9867')]
${LIMITES_SECTION}              xpath://h3[contains(text(),'Límites y disponibles')]
${LIMITES_DETAIL_BUTTON}        xpath://button[contains(text(),'Detalle de límites y disponibles')]
${TOTAL_PAGAR_SECTION}          xpath://h2[contains(text(),'Total a pagar')]
${OPCIONES_TARJETA_SECTION}     xpath://h2[contains(text(),'Opciones de tarjeta')]
${ULTIMO_RESUMEN_SECTION}       xpath://h2[contains(text(),'Último resumen')]
${PROXIMO_RESUMEN_SECTION}      xpath://h2[contains(text(),'Próximo resumen')]

# Information Detail Elements
${LIMITE_TOTAL_DISPLAY}         xpath://*[contains(text(),'Límite total')]
${LIMITE_TOTAL_VALUE}           xpath://*[contains(text(),'$ 14.000.000,00')]
${PAUSAR_TARJETA_SWITCH}        xpath://switch[contains(@aria-label,'Pausar tarjeta')]
${PAYMENT_STATUS_MESSAGE}       xpath://*[contains(text(),'Estás al día con el pago')]
${MOVIMIENTOS_TABLE}            xpath://table
${ADELANTAR_PAGO_BUTTON}        xpath://button[contains(text(),'Adelantar pago')]
${STOP_DEBIT_BUTTON}            xpath://button[contains(text(),'Stop Debit')]
${DESCARGAR_RESUMEN_BUTTON}     xpath://button[contains(text(),'Descargar resumen')]

# Tab Elements
${TAB_CONSUMOS_MES}             xpath://tab[contains(text(),'Consumos del mes')]
${TAB_CUOTAS_PENDIENTES}        xpath://tab[contains(text(),'Cuotas pendientes')]
${TAB_MAS_OPCIONES}             xpath://tab[contains(text(),'Más opciones')]

*** Keywords ***
Navigate To BBVA Login Page
    [Documentation]    Navega a la página de login de BBVA con fallback automático
    
    Log    Navigating to BBVA Login Page
    
    # Intentar con desa1-qa primero
    TRY
        Go To    ${BBVA_ENVIRONMENTS.desa1_qa.login_url}
        Wait For Page Title    ${LOGIN_PAGE_TITLE}    ${EXPLICIT_WAIT}
        Log    Successfully navigated to desa1-qa login page
    EXCEPT
        Log    desa1-qa failed, trying fallback desa16-qa
        Go To    ${BBVA_ENVIRONMENTS.desa16_qa.login_url}
        Wait For Page Title    ${LOGIN_PAGE_TITLE}    ${EXPLICIT_WAIT}
        Log    Successfully navigated to desa16-qa login page (fallback)
    END
    
    # Verify CICS7 is selected
    Wait Until Element Is Visible    ${LOGIN_CICS_SELECTOR}    ${EXPLICIT_WAIT}
    Element Should Be Visible    ${LOGIN_CICS_SELECTOR}

Login To BBVA
    [Documentation]    Realiza login en BBVA con credenciales especificadas
    [Arguments]    ${username}    ${password}    ${dni}=${TEST_DNI}
    
    Log    Performing BBVA login with user: ${username}
    
    # Fill DNI
    Wait Until Element Is Visible    ${LOGIN_DNI_INPUT}    ${EXPLICIT_WAIT}
    Clear Element Text    ${LOGIN_DNI_INPUT}
    Input Text    ${LOGIN_DNI_INPUT}    ${dni}
    
    # Fill Username
    Wait Until Element Is Visible    ${LOGIN_USER_INPUT}    ${EXPLICIT_WAIT}
    Clear Element Text    ${LOGIN_USER_INPUT}
    Input Text    ${LOGIN_USER_INPUT}    ${username}
    
    # Fill Password
    Wait Until Element Is Visible    ${LOGIN_PASSWORD_INPUT}    ${EXPLICIT_WAIT}
    Clear Element Text    ${LOGIN_PASSWORD_INPUT}
    Input Text    ${LOGIN_PASSWORD_INPUT}    ${password}
    
    # Submit login
    Click Element    ${LOGIN_SUBMIT_BUTTON}
    
    # Wait for successful login
    Wait For Page Title    ${DASHBOARD_PAGE_TITLE}    ${EXPLICIT_WAIT}
    
    # Handle potential popup (MODO)
    TRY
        ${popup_present}=    Run Keyword And Return Status    
        ...    Wait Until Element Is Visible    xpath://button[contains(text(),'No me interesa')]    5s
        Run Keyword If    ${popup_present}    Click Element    xpath://button[contains(text(),'No me interesa')]
    EXCEPT
        Log    No popup detected, continuing
    END
    
    Log    Login successful, dashboard loaded

Wait For Dashboard To Load
    [Documentation]    Espera a que el dashboard cargue completamente
    
    Log    Waiting for dashboard to load completely
    
    # Wait for main sections to be visible
    Wait Until Element Is Visible    ${DASHBOARD_CUENTAS_SECTION}    ${EXPLICIT_WAIT}
    Wait Until Element Is Visible    ${DASHBOARD_TARJETAS_SECTION}    ${EXPLICIT_WAIT}
    Wait Until Element Is Visible    ${DASHBOARD_INVERSIONES_SECTION}    ${EXPLICIT_WAIT}
    
    # Additional wait for dynamic content
    Sleep    2s
    
    Log    Dashboard loaded successfully

Validate Dashboard Sections
    [Documentation]    Valida que todas las secciones principales del dashboard estén presentes
    
    Log    Validating dashboard sections
    
    # Verify main sections exist and are visible
    Element Should Be Visible    ${DASHBOARD_CUENTAS_SECTION}
    Element Should Be Visible    ${DASHBOARD_TARJETAS_SECTION}  
    Element Should Be Visible    ${DASHBOARD_INVERSIONES_SECTION}
    
    Log    All dashboard sections validated successfully

Verify Cuentas Section Exists
    [Documentation]    Verifica que la sección Cuentas existe
    
    Element Should Be Visible    ${DASHBOARD_CUENTAS_SECTION}
    Log    Cuentas section exists and is visible

Verify Cuentas Section Content
    [Documentation]    Verifica el contenido de la sección Cuentas
    
    # Check for "Aún no tenés cuentas personales" message
    ${cuentas_message}=    Get WebElement    xpath://*[contains(text(),'Aún no tenés cuentas personales')]
    Element Should Be Visible    ${cuentas_message}
    
    # Check for "Abrir una cuenta" button
    ${abrir_cuenta_btn}=    Get WebElement    xpath://button[contains(text(),'Abrir una cuenta')]
    Element Should Be Visible    ${abrir_cuenta_btn}
    
    Log    Cuentas section content validated

Verify Tarjetas Section Exists
    [Documentation]    Verifica que la sección Tarjetas existe
    
    Element Should Be Visible    ${DASHBOARD_TARJETAS_SECTION}
    Log    Tarjetas section exists and is visible

Verify Tarjetas Section Content
    [Documentation]    Verifica el contenido de la sección Tarjetas
    
    # Verify Visa card is present
    Element Should Be Visible    ${VISA_CARD_BUTTON}
    
    # Verify Mastercard is present
    Element Should Be Visible    ${MASTERCARD_BUTTON}
    
    # Verify card details
    ${visa_text}=    Get Text    ${VISA_CARD_BUTTON}
    Should Contain    ${visa_text}    Visa Signature
    Should Contain    ${visa_text}    ····9867
    
    ${mastercard_text}=    Get Text    ${MASTERCARD_BUTTON}
    Should Contain    ${mastercard_text}    Mastercard Black
    Should Contain    ${mastercard_text}    ····4126
    
    Log    Tarjetas section content validated

Verify Inversiones Section Exists
    [Documentation]    Verifica que la sección Inversiones existe
    
    Element Should Be Visible    ${DASHBOARD_INVERSIONES_SECTION}
    Log    Inversiones section exists and is visible

Verify Inversiones Section Content
    [Documentation]    Verifica el contenido de la sección Inversiones
    
    # Check for "Total de inversiones" text
    ${inversiones_text}=    Get WebElement    xpath://*[contains(text(),'Total de inversiones')]
    Element Should Be Visible    ${inversiones_text}
    
    # Check for "Hacer un plazo fijo" button
    ${plazo_fijo_btn}=    Get WebElement    xpath://button[contains(text(),'Hacer un plazo fijo')]
    Element Should Be Visible    ${plazo_fijo_btn}
    
    Log    Inversiones section content validated

Navigate To Product Detail From Dashboard
    [Documentation]    Navega desde el dashboard al detalle de producto
    
    Log    Navigating to product detail from dashboard
    
    # Click on Visa card to access detail
    Wait Until Element Is Visible    ${VISA_CARD_BUTTON}    ${EXPLICIT_WAIT}
    Click Element    ${VISA_CARD_BUTTON}
    
    # Wait for product detail page to load
    Wait For Page Title    ${TARJETAS_PAGE_TITLE}    ${EXPLICIT_WAIT}
    Wait Until Element Is Visible    ${PRODUCT_HEADER}    ${EXPLICIT_WAIT}
    
    Log    Successfully navigated to product detail

Validate Product Header
    [Documentation]    Valida la información del header del producto
    [Arguments]    ${expected_card_type}    ${expected_last_digits}
    
    Log    Validating product header: ${expected_card_type} ${expected_last_digits}
    
    Wait Until Element Is Visible    ${PRODUCT_HEADER}    ${EXPLICIT_WAIT}
    
    ${header_text}=    Get Text    ${PRODUCT_HEADER}
    Should Contain    ${header_text}    ${expected_card_type}
    Should Contain    ${header_text}    ${expected_last_digits}
    
    Log    Product header validated successfully

Verify Limites Y Disponibles Section
    [Documentation]    Verifica la sección de Límites y Disponibles
    
    Element Should Be Visible    ${LIMITES_SECTION}
    Element Should Be Visible    ${LIMITES_DETAIL_BUTTON}
    
    Log    Límites y Disponibles section verified

Verify Limites Values Display
    [Documentation]    Verifica que los valores de límites se muestren correctamente
    
    # Check for "En 1 pago", "En cuotas", "Adelanto" sections
    ${pago_section}=    Get WebElement    xpath://*[contains(text(),'En 1 pago')]
    ${cuotas_section}=    Get WebElement    xpath://*[contains(text(),'En cuotas')]
    ${adelanto_section}=    Get WebElement    xpath://*[contains(text(),'Adelanto')]
    
    Element Should Be Visible    ${pago_section}
    Element Should Be Visible    ${cuotas_section}
    Element Should Be Visible    ${adelanto_section}
    
    Log    Límites values display verified

Verify Total A Pagar Section
    [Documentation]    Verifica la sección Total a Pagar
    
    Element Should Be Visible    ${TOTAL_PAGAR_SECTION}
    Log    Total a Pagar section verified

Verify Payment Status Message
    [Documentation]    Verifica el mensaje de estado de pago
    
    ${status_message}=    Get WebElement    xpath://*[contains(text(),'Estás al día con el pago')]
    Element Should Be Visible    ${status_message}
    
    Log    Payment status message verified

Verify Opciones Tarjeta Tabs
    [Documentation]    Verifica las pestañas de opciones de tarjeta
    
    Element Should Be Visible    ${OPCIONES_TARJETA_SECTION}
    Element Should Be Visible    ${TAB_CONSUMOS_MES}
    Element Should Be Visible    ${TAB_CUOTAS_PENDIENTES}
    Element Should Be Visible    ${TAB_MAS_OPCIONES}
    
    Log    Opciones de tarjeta tabs verified

Verify Consumos Del Mes Tab
    [Documentation]    Verifica el contenido del tab Consumos del Mes
    
    # Click on tab if not already selected
    ${is_selected}=    Run Keyword And Return Status    
    ...    Element Attribute Value Should Be    ${TAB_CONSUMOS_MES}    aria-selected    true
    
    Run Keyword Unless    ${is_selected}    Click Element    ${TAB_CONSUMOS_MES}
    
    # Verify tab content
    ${movimientos_header}=    Get WebElement    xpath://h3[contains(text(),'Movimientos')]
    Element Should Be Visible    ${movimientos_header}
    
    Log    Consumos del mes tab verified

Verify Cuotas Pendientes Tab
    [Documentation]    Verifica el tab Cuotas Pendientes
    
    Click Element    ${TAB_CUOTAS_PENDIENTES}
    Sleep    1s
    
    # Verify tab is selected
    Element Attribute Value Should Be    ${TAB_CUOTAS_PENDIENTES}    aria-selected    true
    
    Log    Cuotas pendientes tab verified

Verify Mas Opciones Tab
    [Documentation]    Verifica el tab Más Opciones
    
    Click Element    ${TAB_MAS_OPCIONES}
    Sleep    1s
    
    # Verify tab is selected
    Element Attribute Value Should Be    ${TAB_MAS_OPCIONES}    aria-selected    true
    
    Log    Más opciones tab verified

Verify Ultimo Resumen Section
    [Documentation]    Verifica la sección Último Resumen
    
    Element Should Be Visible    ${ULTIMO_RESUMEN_SECTION}
    
    Log    Último resumen section verified

Verify Resumen Details
    [Documentation]    Verifica los detalles del resumen
    
    # Check for key resumen fields
    ${cierre_field}=    Get WebElement    xpath://*[contains(text(),'Cierre')]
    ${vencimiento_field}=    Get WebElement    xpath://*[contains(text(),'Vencimiento')]
    ${saldo_field}=    Get WebElement    xpath://*[contains(text(),'Saldo cierre')]
    
    Element Should Be Visible    ${cierre_field}
    Element Should Be Visible    ${vencimiento_field}
    Element Should Be Visible    ${saldo_field}
    
    Log    Resumen details verified

Verify Proximo Resumen Section
    [Documentation]    Verifica la sección Próximo Resumen
    
    Element Should Be Visible    ${PROXIMO_RESUMEN_SECTION}
    
    Log    Próximo resumen section verified

Click Detalle Limites Y Disponibles Button
    [Documentation]    Hace click en el botón de Detalle de Límites y Disponibles
    
    Wait Until Element Is Visible    ${LIMITES_DETAIL_BUTTON}    ${EXPLICIT_WAIT}
    Click Element    ${LIMITES_DETAIL_BUTTON}
    
    # Wait for expanded content to load
    Sleep    2s
    
    Log    Clicked Detalle Límites y Disponibles button

Validate Limite Total Display
    [Documentation]    Valida que se muestre el Límite Total
    
    Wait Until Element Is Visible    ${LIMITE_TOTAL_DISPLAY}    ${EXPLICIT_WAIT}
    Element Should Be Visible    ${LIMITE_TOTAL_DISPLAY}
    
    Log    Límite Total display validated

Verify Limite Total Value
    [Documentation]    Verifica el valor específico del Límite Total
    [Arguments]    ${expected_value}
    
    Wait Until Element Is Visible    ${LIMITE_TOTAL_VALUE}    ${EXPLICIT_WAIT}
    
    ${actual_value}=    Get Text    ${LIMITE_TOTAL_VALUE}
    Should Be Equal    ${actual_value}    ${expected_value}
    
    Log    Límite Total value verified: ${expected_value}

Verify Pausar Tarjeta Switch Exists
    [Documentation]    Verifica que existe el switch de Pausar Tarjeta
    
    ${switch_element}=    Get WebElement    xpath://*[contains(text(),'Pausar tarjeta')]
    Element Should Be Visible    ${switch_element}
    
    Log    Pausar Tarjeta switch exists

Verify Pausar Tarjeta Switch Functionality
    [Documentation]    Verifica la funcionalidad del switch Pausar Tarjeta
    
    # Verify switch is interactable (could be tested if needed)
    ${switch_element}=    Get WebElement    xpath://switch[contains(@aria-label,'Pausar tarjeta')]
    Element Should Be Enabled    ${switch_element}
    
    Log    Pausar Tarjeta switch functionality verified

Verify Enhanced Payment Status Display
    [Documentation]    Verifica el display mejorado del estado de pago
    
    Wait Until Element Is Visible    ${PAYMENT_STATUS_MESSAGE}    ${EXPLICIT_WAIT}
    Element Should Be Visible    ${PAYMENT_STATUS_MESSAGE}
    
    Log    Enhanced payment status display verified

Verify Payment Status Actions
    [Documentation]    Verifica las acciones disponibles para el estado de pago
    
    Element Should Be Visible    ${ADELANTAR_PAGO_BUTTON}
    Element Should Be Visible    ${STOP_DEBIT_BUTTON}
    
    Log    Payment status actions verified

Verify Movimientos Table Headers
    [Documentation]    Verifica los headers de la tabla de movimientos
    
    # Check for table headers
    ${fecha_header}=    Get WebElement    xpath://th[contains(text(),'Fecha')] | xpath://cell[contains(text(),'Fecha')]
    ${movimiento_header}=    Get WebElement    xpath://th[contains(text(),'Movimiento')] | xpath://cell[contains(text(),'Movimiento')]
    ${cuota_header}=    Get WebElement    xpath://th[contains(text(),'Cuota')] | xpath://cell[contains(text(),'Cuota')]
    ${monto_header}=    Get WebElement    xpath://th[contains(text(),'Monto')] | xpath://cell[contains(text(),'Monto')]
    
    Element Should Be Visible    ${fecha_header}
    Element Should Be Visible    ${movimiento_header}
    Element Should Be Visible    ${cuota_header}
    Element Should Be Visible    ${monto_header}
    
    Log    Movimientos table headers verified

Verify Movimientos Table Structure
    [Documentation]    Verifica la estructura de la tabla de movimientos
    
    # Verify table exists (even if empty)
    ${table_element}=    Get WebElement    xpath://table
    Element Should Be Visible    ${table_element}
    
    Log    Movimientos table structure verified

Verify Adelantar Pago Button
    [Documentation]    Verifica el botón Adelantar Pago
    
    Element Should Be Visible    ${ADELANTAR_PAGO_BUTTON}
    Element Should Be Enabled    ${ADELANTAR_PAGO_BUTTON}
    
    Log    Adelantar Pago button verified

Verify Stop Debit Buttons
    [Documentation]    Verifica los botones Stop Debit
    
    Element Should Be Visible    ${STOP_DEBIT_BUTTON}
    Element Should Be Enabled    ${STOP_DEBIT_BUTTON}
    
    Log    Stop Debit buttons verified

Verify Descargar Resumen Button
    [Documentation]    Verifica el botón Descargar Resumen
    
    Element Should Be Visible    ${DESCARGAR_RESUMEN_BUTTON}
    Element Should Be Enabled    ${DESCARGAR_RESUMEN_BUTTON}
    
    Log    Descargar Resumen button verified

Validate All Information Fields Populated
    [Documentation]    Valida que todos los campos de información estén poblados
    
    # Verify key information fields have content
    Verify Limite Total Value    $ 14.000.000,00
    Verify Payment Status Message
    Verify Resumen Details
    
    Log    All information fields validated as populated

Take Test Evidence Screenshot
    [Documentation]    Toma screenshot como evidencia del test
    [Arguments]    ${screenshot_name}
    
    ${timestamp}=    Get Current Date    result_format=%Y%m%d-%H%M%S
    ${filename}=    Set Variable    ${screenshot_name}-${timestamp}.png
    ${filepath}=    Join Path    ${SCREENSHOT_DIR}    ${filename}
    
    Capture Page Screenshot    ${filepath}
    
    Log    Screenshot taken: ${filename}
    
    RETURN    ${filepath}

Set Browser Viewport
    [Documentation]    Configura el viewport del navegador para testing responsive
    [Arguments]    ${viewport_config}
    
    ${width}=    Get From Dictionary    ${viewport_config}    width
    ${height}=    Get From Dictionary    ${viewport_config}    height
    
    Set Window Size    ${width}    ${height}
    Sleep    1s
    
    Log    Browser viewport set to ${width}x${height}

Execute Dashboard Validation Flow
    [Documentation]    Ejecuta el flujo completo de validación del dashboard
    
    Wait For Dashboard To Load
    Validate Dashboard Sections
    Verify Cuentas Section Exists
    Verify Cuentas Section Content
    Verify Tarjetas Section Exists
    Verify Tarjetas Section Content
    Verify Inversiones Section Exists
    Verify Inversiones Section Content

Execute Product Detail Flow
    [Documentation]    Ejecuta el flujo de navegación y validación del detalle de producto
    
    Navigate To Product Detail From Dashboard
    Validate Product Header    Visa Signature    ····9867
    Verify Limites Y Disponibles Section
    Verify Total A Pagar Section
    Verify Opciones Tarjeta Tabs
    Verify Ultimo Resumen Section
    Verify Proximo Resumen Section

Execute Information Detail Flow
    [Documentation]    Ejecuta el flujo de validación del detalle de información
    
    Click Detalle Limites Y Disponibles Button
    Validate Limite Total Display
    Verify Limite Total Value    $ 14.000.000,00
    Verify Pausar Tarjeta Switch Exists
    Verify Enhanced Payment Status Display
    Verify Movimientos Table Headers
    Verify Payment Status Actions