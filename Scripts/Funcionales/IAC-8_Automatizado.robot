*** Settings ***
Documentation     Test Suite para Simulador de Crédito Banco Pichincha
...               Automatización de pruebas para validar funcionalidad del simulador
...               URL: https://www.pichincha.com/detalle-producto/simulador-de-credito
Library           SeleniumLibrary
Library           BuiltIn
Library           Collections
Suite Setup       Abrir Navegador Y Navegar Al Simulador
Suite Teardown    Close Browser
Test Setup        Navegar Al Simulador
Test Teardown     Capture Page Screenshot

*** Variables ***
${URL}                    https://www.pichincha.com/detalle-producto/simulador-de-credito
${BROWSER}               Chrome
${TIMEOUT}               10s
${SCREENSHOTS_DIR}       ${EXECDIR}${/}Scripts${/}Evidencias${/}IAC-8${/}screenshots${/}

# Locators
${DROPDOWN_CREDITO}      id=selcProduct
${INPUT_VALOR_VIVIENDA}  xpath=//input[@placeholder='Ej. $1000'][1]
${INPUT_MONTO_FINANCIAR}  xpath=//input[@placeholder='Ej. $1000'][last()]
${DROPDOWN_PLAZO}        id=selectplazo
${METODO_FRANCES}        xpath=//generic[@title='Frances']
${METODO_ALEMAN}         xpath=//generic[@title='Aleman']
${BOTON_SIMULAR}         id=BtnSimu
${RESULTADO_CUOTA}       xpath=//paragraph[contains(text(),'$') and contains(@class,'cuota-mensual')]

# Datos de Prueba
${VALOR_VIVIENDA}        80000
${MONTO_FINANCIAR}       50000
${MONTO_CONSUMO}         15000
${PLAZO_HIPOTECARIO}     120 meses (10.0 años)
${PLAZO_CONSUMO}         24 meses (2.0 años)

*** Test Cases ***
TC001 Simulacion Hipotecaria Metodo Frances
    [Documentation]    Validar simulación de crédito hipotecario con método francés
    [Tags]             hipotecario    frances    critico
    
    Seleccionar Tipo De Credito    Hipotecario vivienda
    Ingresar Valor De La Vivienda  ${VALOR_VIVIENDA}
    Ingresar Monto A Financiar     ${MONTO_FINANCIAR}
    Seleccionar Plazo              ${PLAZO_HIPOTECARIO}
    Seleccionar Metodo Frances
    Ejecutar Simulacion
    
    ${cuota_mensual}=    Obtener Cuota Mensual
    ${tasa_interes}=     Obtener Tasa De Interes
    ${total_pagar}=      Obtener Total A Pagar
    
    # Validaciones
    Should Be True       ${cuota_mensual} > 600
    Should Be True       ${cuota_mensual} < 800
    Should Contain       ${tasa_interes}    10.07%
    Should Be True       ${total_pagar} > 80000
    
    Capture Element Screenshot    ${RESULTADO_CUOTA}    TC001_resultado_frances.png
    Log    Cuota mensual calculada: $${cuota_mensual}

TC002 Simulacion Hipotecaria Metodo Aleman
    [Documentation]    Validar simulación de crédito hipotecario con método alemán
    [Tags]             hipotecario    aleman    critico
    
    Seleccionar Tipo De Credito    Hipotecario vivienda
    Ingresar Valor De La Vivienda  ${VALOR_VIVIENDA}
    Ingresar Monto A Financiar     ${MONTO_FINANCIAR}
    Seleccionar Plazo              ${PLAZO_HIPOTECARIO}
    Seleccionar Metodo Aleman
    Ejecutar Simulacion
    
    ${cuota_inicial}=    Obtener Cuota Mensual
    ${tasa_interes}=     Obtener Tasa De Interes
    ${total_pagar}=      Obtener Total A Pagar
    
    # Validaciones específicas método alemán
    Should Be True       ${cuota_inicial} > 800    # Primera cuota más alta
    Should Be True       ${cuota_inicial} < 900
    Should Contain       ${tasa_interes}    10.07%
    Should Be True       ${total_pagar} < 80000    # Total menor que francés
    
    Capture Element Screenshot    ${RESULTADO_CUOTA}    TC002_resultado_aleman.png
    Log    Primera cuota (alemán): $${cuota_inicial}

TC003 Simulacion Credito De Consumo
    [Documentation]    Validar simulación de crédito de consumo tipo Preciso
    [Tags]             consumo    preciso    medio
    
    Seleccionar Tipo De Credito    Preciso
    Ingresar Monto A Financiar     ${MONTO_CONSUMO}
    Seleccionar Plazo              ${PLAZO_CONSUMO}
    Seleccionar Metodo Frances
    Ejecutar Simulacion
    
    ${cuota_mensual}=    Obtener Cuota Mensual
    ${tasa_interes}=     Obtener Tasa De Interes
    ${total_pagar}=      Obtener Total A Pagar
    
    # Validaciones crédito de consumo
    Should Be True       ${cuota_mensual} > 700
    Should Be True       ${cuota_mensual} < 800
    Should Contain       ${tasa_interes}    15.6%    # Tasa más alta que hipotecario
    Should Be True       ${total_pagar} > 17000
    Should Be True       ${total_pagar} < 19000
    
    Capture Element Screenshot    ${RESULTADO_CUOTA}    TC003_resultado_consumo.png
    Log    Cuota consumo calculada: $${cuota_mensual}

TC004 Validacion Cambio Dinamico De Formulario
    [Documentation]    Verificar que el formulario se adapta según tipo de crédito
    [Tags]             formulario    dinamico    funcional
    
    # Verificar formulario hipotecario
    Seleccionar Tipo De Credito    Hipotecario vivienda
    Element Should Be Visible      ${INPUT_VALOR_VIVIENDA}
    
    # Verificar formulario consumo
    Seleccionar Tipo De Credito    Preciso
    Element Should Not Be Visible  ${INPUT_VALOR_VIVIENDA}
    
    # Verificar plazos diferentes
    ${opciones_consumo}=    Get List Items    ${DROPDOWN_PLAZO}
    Should Not Contain     ${opciones_consumo}    240 meses
    
    Log    Formulario se adapta correctamente según tipo de crédito

TC005 Validacion Montos Minimos
    [Documentation]    Verificar validaciones de montos mínimos
    [Tags]             validacion    montos    funcional
    
    # Hipotecario - mínimo $3,000
    Seleccionar Tipo De Credito    Hipotecario vivienda
    Ingresar Valor De La Vivienda  10000
    Ingresar Monto A Financiar     2999
    Element Should Be Disabled     ${BOTON_SIMULAR}
    
    # Consumo - mínimo $300
    Seleccionar Tipo De Credito    Preciso
    Ingresar Monto A Financiar     299
    Element Should Be Disabled     ${BOTON_SIMULAR}
    
    Log    Validaciones de montos mínimos funcionan correctamente

*** Keywords ***
Abrir Navegador Y Navegar Al Simulador
    [Documentation]    Setup inicial del navegador
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Timeout    ${TIMEOUT}
    Wait Until Page Contains    Simulador de Crédito
    
Navegar Al Simulador
    [Documentation]    Navegar a la página del simulador
    Go To    ${URL}
    Wait Until Page Contains    Simulador de Crédito

Seleccionar Tipo De Credito
    [Arguments]    ${tipo_credito}
    [Documentation]    Seleccionar tipo de crédito del dropdown
    Select From List By Label    ${DROPDOWN_CREDITO}    ${tipo_credito}
    Sleep    1s    # Esperar que el formulario se actualice

Ingresar Valor De La Vivienda
    [Arguments]    ${valor}
    [Documentation]    Ingresar valor de la vivienda (solo hipotecarios)
    Wait Until Element Is Visible    ${INPUT_VALOR_VIVIENDA}
    Clear Element Text    ${INPUT_VALOR_VIVIENDA}
    Input Text    ${INPUT_VALOR_VIVIENDA}    ${valor}

Ingresar Monto A Financiar
    [Arguments]    ${monto}
    [Documentation]    Ingresar monto a financiar
    Wait Until Element Is Visible    ${INPUT_MONTO_FINANCIAR}
    Clear Element Text    ${INPUT_MONTO_FINANCIAR}
    Input Text    ${INPUT_MONTO_FINANCIAR}    ${monto}

Seleccionar Plazo
    [Arguments]    ${plazo}
    [Documentation]    Seleccionar plazo del dropdown
    Select From List By Label    ${DROPDOWN_PLAZO}    ${plazo}

Seleccionar Metodo Frances
    [Documentation]    Seleccionar método de amortización francés
    Click Element    ${METODO_FRANCES}

Seleccionar Metodo Aleman
    [Documentation]    Seleccionar método de amortización alemán
    Click Element    ${METODO_ALEMAN}

Ejecutar Simulacion
    [Documentation]    Hacer clic en el botón simular y esperar resultados
    Wait Until Element Is Enabled    ${BOTON_SIMULAR}
    Click Button    ${BOTON_SIMULAR}
    Sleep    2s    # Esperar cálculo
    Wait Until Page Contains    Tus pagos mensuales serán

Obtener Cuota Mensual
    [Documentation]    Extraer valor de cuota mensual de los resultados
    ${elemento_cuota}=    Get WebElement    xpath=//paragraph[contains(@class,'cuota-total')]//strong
    ${cuota_texto}=      Get Text    ${elemento_cuota}
    ${cuota_numero}=     Evaluate    "${cuota_texto}".replace('$','').replace(',','')
    [Return]    ${cuota_numero}

Obtener Tasa De Interes
    [Documentation]    Extraer tasa de interés de los resultados
    ${tasa_elemento}=    Get WebElement    xpath=//paragraph[contains(text(),'tasa de interés referencial')]
    ${tasa_texto}=       Get Text    ${tasa_elemento}
    [Return]    ${tasa_texto}

Obtener Total A Pagar
    [Documentation]    Extraer total a pagar de los resultados
    ${total_elemento}=   Get WebElement    xpath=//paragraph[text()='Total a pagar:']/following-sibling::paragraph/strong
    ${total_texto}=      Get Text    ${total_elemento}
    ${total_numero}=     Evaluate    "${total_texto}".replace('$','').replace(',','')
    [Return]    ${total_numero}

Validar Calculo Matematico
    [Arguments]    ${capital}    ${tasa_anual}    ${plazo_meses}    ${cuota_esperada}
    [Documentation]    Validar cálculo de cuota usando fórmula PMT
    ${tasa_mensual}=     Evaluate    ${tasa_anual} / 100 / 12
    ${factor}=           Evaluate    (1 + ${tasa_mensual}) ** ${plazo_meses}
    ${pmt_calculado}=    Evaluate    ${capital} * ${tasa_mensual} * ${factor} / (${factor} - 1)
    ${diferencia}=       Evaluate    abs(${pmt_calculado} - ${cuota_esperada})
    Should Be True       ${diferencia} < 1    # Tolerancia de $1
    [Return]    ${pmt_calculado}