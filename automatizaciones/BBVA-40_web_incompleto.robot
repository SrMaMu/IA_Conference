*** Settings ***
Documentation    BBVA-40 - Automatización Web (INCOMPLETO)
Library          SeleniumLibrary

*** Variables ***
${URL}           https://desa1-qa.bbva.com.ar/fnetcore/login/index.html
${TIPO_DOC_BTN}  e46
${NUM_DOC_TXT}   e61
${USUARIO_TXT}   e68
${CLAVE_TXT}     e77
${INGRESAR_BTN}  e121

*** Test Cases ***
Login Web BBVA-40
    [Documentation]    Login web con usuario real (sin CS). Script incompleto, solo login.
    Open Browser    ${URL}    Chrome
    # Seleccionar tipo de documento DNI
    # Input número de documento
    # Input usuario
    # Input clave
    # Click en Ingresar
    # Validar avance (Cargando...)
    [Teardown]    Close Browser

# Estado: INCOMPLETO. Falta automatizar navegación y validaciones posteriores.