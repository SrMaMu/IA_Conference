*** Settings ***
Documentation    Script automatizado generado para IAC-8 - Simulador de Crédito Banco Pichincha
...              Basado en ejecución exploratoria con Playwright
...              Fecha: 25 de Septiembre de 2025
...              URL: https://www.pichincha.com/detalle-producto/simulador-de-credito

Library          SeleniumLibrary

*** Variables ***
${URL}                  https://www.pichincha.com/detalle-producto/simulador-de-credito
${BROWSER}              Chrome
${TIMEOUT}              30s
${SCREENSHOT_DIR}       Scripts/Evidencias/IAC-8/screenshots

# Datos de prueba para simulación
${TIPO_CREDITO}         9c3f41c9-446d-461b-a190-6747ff2cc879    # Hipotecario vivienda
${VALOR_VIVIENDA}       80000
${MONTO_PRESTAMO}       50000
${PLAZO_MESES}          120
${METODO_AMORTIZACION}  Frances

*** Test Cases ***
IAC-8 - TC001 Calcular cuota mensual con datos válidos
    [Documentation]    Escenario: Calcular cuota mensual con datos válidos
    ...                Given que estoy en el simulador de crédito
    ...                When selecciono crédito hipotecario vivienda
    ...                And ingreso valor de vivienda "$80,000"
    ...                And ingreso monto a financiar "$50,000"
    ...                And selecciono plazo de "120 meses"
    ...                And selecciono método de amortización "Francés"
    ...                And presiono el botón simular
    ...                Then el sistema debe mostrar la cuota mensual calculada
    ...                And debe mostrar el desglose detallado del crédito
    [Tags]             IAC-8    automated    calculator    regression
    
    # Setup
    Open Browser                 ${URL}    ${BROWSER}
    Maximize Browser Window
    
    # Given que estoy en el simulador de crédito
    Given usuario accede al simulador de credito
    
    # When selecciono crédito hipotecario vivienda
    When usuario selecciona tipo de credito hipotecario
    
    # And ingreso valor de vivienda "$80,000"
    And usuario ingresa valor de vivienda    ${VALOR_VIVIENDA}
    
    # And ingreso monto a financiar "$50,000"
    And usuario ingresa monto a financiar    ${MONTO_PRESTAMO}
    
    # And selecciono plazo de "120 meses"
    And usuario selecciona plazo de         ${PLAZO_MESES}
    
    # And selecciono método de amortización "Francés"
    And usuario selecciona metodo de amortizacion    ${METODO_AMORTIZACION}
    
    # And presiono el botón simular
    And usuario ejecuta la simulacion
    
    # Then el sistema debe mostrar la cuota mensual calculada
    Then el sistema debe mostrar cuota mensual calculada
    
    # And debe mostrar el desglose detallado del crédito
    And debe mostrar desglose detallado del credito
    
    # Cleanup
    [Teardown]    Close Browser

*** Keywords ***
Given usuario accede al simulador de credito
    [Documentation]    Precondición: Navegar al simulador y validar carga
    Wait Until Page Contains Element    id=selcProduct    ${TIMEOUT}
    Wait Until Element Is Visible       id=selcProduct    ${TIMEOUT}
    Page Should Contain                 Simulador de Crédito
    Capture Page Screenshot            IAC-8_TC001_acceso_simulador.png

When usuario selecciona tipo de credito hipotecario
    [Documentation]    Seleccionar "Hipotecario vivienda" del dropdown principal
    Wait Until Element Is Visible      id=selcProduct                ${TIMEOUT}
    Wait Until Element Is Enabled      id=selcProduct                ${TIMEOUT}
    Select From List By Value          id=selcProduct                ${TIPO_CREDITO}
    Sleep                              5s                            # Esperar carga de campos dinámicos
    Capture Page Screenshot            IAC-8_TC001_tipo_credito_seleccionado.png

And usuario ingresa valor de vivienda
    [Documentation]    Ingresar valor de la vivienda en el campo correspondiente
    [Arguments]    ${valor}
    Wait Until Element Is Visible      xpath=//input[@id='inputVivienda']    20s
    Wait Until Element Is Enabled      xpath=//input[@id='inputVivienda']    20s
    Click Element                      xpath=//input[@id='inputVivienda']
    Sleep                              2s
    Clear Element Text                 xpath=//input[@id='inputVivienda']
    Input Text                         xpath=//input[@id='inputVivienda']    ${valor}
    Sleep                              3s
    Capture Page Screenshot            IAC-8_TC001_valor_vivienda_ingresado.png

And usuario ingresa monto a financiar
    [Documentation]    Ingresar monto que se desea financiar
    [Arguments]    ${monto}
    Wait Until Element Is Visible      xpath=//input[@id='inputdinero']      20s
    Wait Until Element Is Enabled      xpath=//input[@id='inputdinero']      20s
    Click Element                      xpath=//input[@id='inputdinero']
    Sleep                              2s
    Clear Element Text                 xpath=//input[@id='inputdinero']
    Input Text                         xpath=//input[@id='inputdinero']      ${monto}
    Sleep                              3s
    Capture Page Screenshot            IAC-8_TC001_monto_financiar_ingresado.png

And usuario selecciona plazo de
    [Documentation]    Seleccionar plazo en meses del dropdown
    [Arguments]    ${plazo}
    Wait Until Element Is Visible      xpath=//select[@id='selectplazo']     20s
    Wait Until Element Is Enabled      xpath=//select[@id='selectplazo']     20s
    Select From List By Value          xpath=//select[@id='selectplazo']     ${plazo}
    Sleep                              3s
    Capture Page Screenshot            IAC-8_TC001_plazo_seleccionado.png

And usuario selecciona metodo de amortizacion
    [Documentation]    Seleccionar método de amortización (Francés o Alemán)
    [Arguments]    ${metodo}
    Wait Until Element Is Visible      xpath=//div[@title='${metodo}']       20s
    Click Element                      xpath=//div[@title='${metodo}']
    Sleep                              2s
    Capture Page Screenshot            IAC-8_TC001_metodo_seleccionado.png

And usuario ejecuta la simulacion
    [Documentation]    Hacer clic en el botón Simular para calcular
    Wait Until Element Is Visible      xpath=//button[@id='BtnSimu']         20s
    Wait Until Element Is Enabled      xpath=//button[@id='BtnSimu']         20s
    Click Element                      xpath=//button[@id='BtnSimu']
    Sleep                              5s                                   # Esperar cálculo
    Capture Page Screenshot            IAC-8_TC001_simulacion_ejecutada.png

Then el sistema debe mostrar cuota mensual calculada
    [Documentation]    Validar que se muestre la cuota mensual calculada
    Wait Until Element Is Visible      xpath=//*[contains(text(), '$') and contains(text(), ',')]    30s
    Page Should Contain                $
    Page Should Not Contain            $0,00
    Element Should Be Visible          xpath=//*[contains(text(), 'Capital')]
    Element Should Be Visible          xpath=//*[contains(text(), 'Interés')]
    Element Should Be Visible          xpath=//*[contains(text(), 'Seguro')]
    Capture Page Screenshot            IAC-8_TC001_cuota_mensual_mostrada.png

And debe mostrar desglose detallado del credito
    [Documentation]    Validar desglose completo del crédito calculado
    Wait Until Element Is Visible      xpath=//*[contains(text(), 'Total a pagar')]     30s
    Element Should Be Visible          xpath=//*[contains(text(), 'Capital:')]
    Element Should Be Visible          xpath=//*[contains(text(), 'Total de interés:')]
    Element Should Be Visible          xpath=//*[contains(text(), 'Total seguro de desgravamen:')]
    Element Should Be Visible          xpath=//*[contains(text(), 'Total a pagar:')]
    Page Should Contain                Durante ${PLAZO_MESES} meses
    Capture Page Screenshot            IAC-8_TC001_desglose_detallado.png