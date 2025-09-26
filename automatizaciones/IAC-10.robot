*** Settings ***
Documentation    Script automatizado generado para IAC-10 - Pruebas de Accesibilidad Argentina.gob.ar
...              Basado en ejecución exploratoria con Playwright
...              Fecha: 25 de Septiembre de 2025
...              URL: https://www.argentina.gob.ar/

Library          SeleniumLibrary

*** Variables ***
${URL}              https://www.argentina.gob.ar/
${BROWSER}          Chrome
${TIMEOUT}          30s
${SCREENSHOT_DIR}   Scripts/Evidencias/IAC-10/screenshots

*** Test Cases ***
IAC-10 - TC001 Navegación inicial y validación de accesibilidad
    [Documentation]    Escenario: Validar accesibilidad del sitio web gubernamental
    ...                Given que estoy en la página de inicio de Argentina.gob.ar
    ...                When navego por las secciones principales del sitio
    ...                Then el contenido debe ser accesible y funcional
    ...                And todos los enlaces principales deben funcionar correctamente
    [Tags]             IAC-10    automated    accessibility    regression
    
    # Setup
    Open Browser                 ${URL}    ${BROWSER}
    Maximize Browser Window
    
    # Given que estoy en la página de inicio de Argentina.gob.ar
    Given usuario accede al sitio argentina.gob.ar
    
    # When navego por las secciones principales del sitio
    When usuario explora las secciones principales
    
    # Then el contenido debe ser accesible y funcional
    Then el sitio debe mostrar contenido accesible
    And todos los elementos principales deben estar presentes
    
    # Cleanup
    [Teardown]    Close Browser

IAC-10 - TC002 Documentación de contenido disponible
    [Documentation]    Escenario: Verificar que la documentación esté disponible
    ...                Given que estoy en el sitio web
    ...                When busco información sobre trámites
    ...                Then debo encontrar documentación clara y accesible
    [Tags]             IAC-10    automated    documentation    regression
    
    # Setup
    Open Browser                 ${URL}    ${BROWSER}
    Maximize Browser Window
    
    # Given que estoy en el sitio web
    Given usuario accede al sitio argentina.gob.ar
    
    # When busco información sobre trámites
    When usuario busca información de trámites
    
    # Then debo encontrar documentación clara y accesible
    Then la documentación debe estar disponible
    And los enlaces de trámites deben funcionar
    
    # Cleanup
    [Teardown]    Close Browser

*** Keywords ***
Given usuario accede al sitio argentina.gob.ar
    [Documentation]    Precondición: Navegar al sitio y validar carga inicial
    Wait Until Page Contains Element    xpath=//header    ${TIMEOUT}
    Wait Until Page Contains Element    xpath=//nav       ${TIMEOUT}
    Page Should Contain                 Argentina.gob.ar
    Capture Page Screenshot            IAC-10_TC001_inicio_navegacion.png

When usuario explora las secciones principales
    [Documentation]    Acción: Navegar por las secciones principales del sitio
    Wait Until Element Is Visible      xpath=//nav//a[contains(@href, 'tramites') or contains(text(), 'Trámites')]    ${TIMEOUT}
    Click Element                      xpath=//nav//a[contains(@href, 'tramites') or contains(text(), 'Trámites')]
    Sleep                              3s
    Go Back
    Sleep                              2s

When usuario busca información de trámites
    [Documentation]    Acción: Buscar información específica sobre trámites
    Wait Until Element Is Visible      xpath=//nav//a[contains(@href, 'tramites') or contains(text(), 'Trámites')]    ${TIMEOUT}
    Click Element                      xpath=//nav//a[contains(@href, 'tramites') or contains(text(), 'Trámites')]
    Sleep                              3s
    Capture Page Screenshot            IAC-10_TC002_seccion_tramites.png

Then el sitio debe mostrar contenido accesible
    [Documentation]    Validación: Verificar elementos de accesibilidad
    Page Should Contain Element        xpath=//header
    Page Should Contain Element        xpath=//nav
    Page Should Contain Element        xpath=//main
    Capture Page Screenshot            IAC-10_TC001_validacion_accesibilidad.png

And todos los elementos principales deben estar presentes
    [Documentation]    Validación: Confirmar presencia de elementos clave
    Wait Until Element Is Visible      xpath=//nav//a[contains(@href, 'tramites') or contains(text(), 'Trámites')]    ${TIMEOUT}
    Element Should Be Visible          xpath=//nav//a[contains(@href, 'tramites') or contains(text(), 'Trámites')]
    Page Should Contain                Trámites

Then la documentación debe estar disponible
    [Documentation]    Validación: Verificar disponibilidad de documentación
    Page Should Contain Element        xpath=//main
    Page Should Not Contain            Error 404
    Page Should Not Contain            Página no encontrada
    Capture Page Screenshot            IAC-10_TC002_documentacion_disponible.png

And los enlaces de trámites deben funcionar
    [Documentation]    Validación: Confirmar funcionalidad de enlaces
    Wait Until Element Is Visible      xpath=//nav//a[contains(@href, 'tramites') or contains(text(), 'Trámites')]    ${TIMEOUT}
    Element Should Be Enabled          xpath=//nav//a[contains(@href, 'tramites') or contains(text(), 'Trámites')]
    Capture Page Screenshot            IAC-10_TC002_enlaces_funcionales.png