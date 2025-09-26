---
applyTo: '**/*.robot'
---
# Robot Framework - Mejores Prácticas para Automatización Web

## 📋 Guía de Creación y Mapeo de Elementos

Este documento documenta las mejores prácticas aprendidas durante la creación del script de automatización del simulador de crédito de Banco Pichincha.

---

## 🔍 Proceso de Mapeo de Elementos DOM

### 1. Investigación Previa con Herramientas Complementarias

**✅ HACER:**
- Usar **Playwright MCP Server** para navegar y mapear elementos DOM reales
- Ejecutar el flujo manualmente para identificar comportamientos dinámicos
- Extraer selectores exactos usando JavaScript en el navegador
- Verificar que los elementos aparecen/desaparecen dinámicamente

**❌ EVITAR:**
- Asumir selectores sin verificar en el DOM real
- Usar selectores genéricos como `xpath=//select` sin especificidad
- No considerar elementos que se cargan dinámicamente

### 2. Identificación de Elementos Críticos

Durante nuestro mapeo identificamos estos elementos clave:
```html
<!-- Selector de tipo de crédito -->
<select id="selcProduct" class="selcProduct">
  <option value="9c3f41c9-446d-461b-a190-6747ff2cc879">Hipotecario vivienda</option>
</select>

<!-- Campos de entrada que aparecen dinámicamente -->
<input type="text" id="inputVivienda" class="inputVivienda" placeholder="Ej. $1000">
<input type="text" id="inputdinero" class="inputdinero" placeholder="Ej. $1000">

<!-- Selector de plazo -->
<select id="selectplazo" class="selectplazo">
  <option value="120">120 meses (10.0 años)</option>
</select>

<!-- Método de pago -->
<div title="Frances">Método Francés</div>

<!-- Botón de simulación -->
<button id="BtnSimu" class="BtnSimu">Simular</button>
```

---

## 🎯 Estrategias de Selectors

### Orden de Preferencia para Selectores:

1. **ID directo (MÁS CONFIABLE)**: `id=elementId`
2. **XPath con ID específico**: `xpath=//input[@id='elementId']`
3. **XPath con atributos únicos**: `xpath=//div[@title='Frances']`
4. **Class + tipo**: `xpath=//select[@class='selectplazo']`

### Ejemplos de Selectores Exitosos:
```robot
# ✅ FUNCIONA - ID directo
Wait Until Element Is Visible    id=selcProduct    30s

# ✅ FUNCIONA - XPath con ID específico
Wait Until Element Is Visible    xpath=//input[@id='inputVivienda']    20s

# ✅ FUNCIONA - XPath con atributo único
Wait Until Element Is Visible    xpath=//div[@title='Frances']    20s

# ❌ NO FUNCIONA - Demasiado genérico
Wait Until Element Is Visible    xpath=//select    15s
Wait Until Element Is Visible    xpath=//input[@placeholder='Ej. $1000']    10s
```

---

## ⏱️ Manejo de Timing y Estados de Elementos

### Patrón de Espera Robusto:

```robot
# 1. Esperar visibilidad
Wait Until Element Is Visible    xpath=//input[@id='inputVivienda']    20s

# 2. Esperar habilitación
Wait Until Element Is Enabled    xpath=//input[@id='inputVivienda']    20s

# 3. Hacer clic para activar (elementos dinámicos)
Click Element    xpath=//input[@id='inputVivienda']

# 4. Espera corta para estabilización
Sleep    2s

# 5. Acción principal
Input Text    xpath=//input[@id='inputVivienda']    80000
```

### Tiempos de Espera Recomendados:
- **Carga inicial de página**: 30s
- **Elementos dinámicos**: 20s
- **Estabilización post-acción**: 2-3s
- **Entre campos del formulario**: 3s

---

## 🔄 Manejo de Elementos Dinámicos

### Problema Común:
Los elementos se deshabilitan temporalmente cuando se selecciona una opción y necesitan tiempo para habilitarse.

### Solución Implementada:
```robot
# Seleccionar opción en dropdown
Select From List By Value    id=selcProduct    9c3f41c9-446d-461b-a190-6747ff2cc879

# CRUCIAL: Esperar que los nuevos elementos se carguen
Sleep    5s

# Entonces proceder con los elementos que aparecieron dinámicamente
Wait Until Element Is Visible    xpath=//input[@id='inputVivienda']    20s
```

---

## � Librerías Recomendadas

### ✅ **Librerías Esenciales:**
```robot
*** Settings ***
Library          SeleniumLibrary    # Para automatización web
```

### ❌ **Librerías NO Necesarias para Automatización Web:**
```robot
# ❌ NO usar ScreenCapLibrary para automatización web
# Library          ScreenCapLibrary    # Solo para capturas de escritorio
```

**Razón**: SeleniumLibrary ya incluye `Capture Page Screenshot` que es suficiente para automatización web. ScreenCapLibrary solo se usa para aplicaciones de escritorio o capturas del sistema operativo completo.

---

## �📝 Estructura de Script Recomendada

### Template Básico:
```robot
*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://ejemplo.com

*** Test Cases ***
Nombre Del Test
    # 1. Configuración inicial
    Open Browser    ${URL}    Chrome
    Maximize Browser Window
    
    # 2. Esperar carga inicial
    Wait Until Page Contains Element    xpath=//elemento-clave    30s
    
    # 3. Interacciones con patrón robusto
    Wait Until Element Is Visible    xpath=//elemento    20s
    Wait Until Element Is Enabled    xpath=//elemento    20s
    Click Element    xpath=//elemento
    Sleep    2s
    Input Text    xpath=//elemento    valor
    
    # 4. Esperas entre secciones
    Sleep    3s
    
    # 5. Validación
    Wait Until Element Is Visible    xpath=//resultado    30s
    
    # 6. Cleanup
    Capture Page Screenshot
    [Teardown]    Close Browser
```

### Template con Estructura Gherkin:
```robot
*** Settings ***
Documentation    Script automatizado generado para {TICKET-ID}
...              Basado en ejecución exploratoria con Playwright
...              Fecha: ${FECHA_GENERACION}
...              URL: ${URL_APPLICATION}

Library          SeleniumLibrary

*** Variables ***
${URL}              ${URL_DE_LA_APLICACION}
${BROWSER}          Chrome
${TIMEOUT}          30s

*** Test Cases ***
{TICKET-ID} - TC001 Nombre del Caso de Prueba
    [Documentation]    Escenario: Descripción del escenario Gherkin
    ...                Given [precondiciones específicas]
    ...                When [acciones del usuario paso a paso]
    ...                Then [resultados esperados verificables]
    [Tags]             {TICKET-ID}    automated    regression
    
    # Setup
    Open Browser                 ${URL}    ${BROWSER}
    Maximize Browser Window
    
    # Given [precondiciones específicas]
    Given usuario accede al sistema
    
    # When [acciones del usuario paso a paso]
    When usuario realiza las acciones principales
    
    # Then [resultados esperados verificables]
    Then el sistema debe mostrar los resultados esperados
    And todas las validaciones deben pasar
    
    # Cleanup
    [Teardown]    Close Browser

*** Keywords ***
Given usuario accede al sistema
    [Documentation]    Precondición: Navegar al sitio y validar carga inicial
    Wait Until Page Contains Element    xpath=//elemento-principal    ${TIMEOUT}
    Page Should Contain                 Texto esperado en la página
    Capture Page Screenshot            {TICKET-ID}_TC001_acceso_inicial.png

When usuario realiza las acciones principales
    [Documentation]    Acción: Ejecutar las acciones principales del caso de prueba
    Wait Until Element Is Visible      xpath=//elemento-accion    ${TIMEOUT}
    Click Element                      xpath=//elemento-accion
    Sleep                              3s
    Capture Page Screenshot            {TICKET-ID}_TC001_accion_ejecutada.png

Then el sistema debe mostrar los resultados esperados
    [Documentation]    Validación: Verificar que los resultados son los esperados
    Wait Until Element Is Visible      xpath=//resultado    ${TIMEOUT}
    Element Should Be Visible          xpath=//resultado
    Page Should Contain                Resultado esperado
    Capture Page Screenshot            {TICKET-ID}_TC001_resultado_validado.png

And todas las validaciones deben pasar
    [Documentation]    Validación adicional: Confirmar validaciones complementarias
    Page Should Not Contain            Error
    Element Should Be Enabled          xpath=//elemento-habilitado
    Capture Page Screenshot            {TICKET-ID}_TC001_validaciones_completas.png
```

---

## 🚫 Errores Comunes y Soluciones

### Error: "InvalidElementStateException: invalid element state"

**Causa**: Intentar interactuar con elemento que no está completamente habilitado

**Solución**:
```robot
# ❌ MAL
Input Text    id=campo    valor

# ✅ BIEN
Wait Until Element Is Visible    xpath=//input[@id='campo']    20s
Wait Until Element Is Enabled    xpath=//input[@id='campo']    20s
Click Element    xpath=//input[@id='campo']
Sleep    2s
Input Text    xpath=//input[@id='campo']    valor
```

### Error: "Element not visible" en elementos dinámicos

**Causa**: Elementos que aparecen después de seleccionar opciones

**Solución**:
```robot
# Seleccionar opción que trigger nuevos elementos
Select From List By Value    id=selector    valor

# ESPERAR que los elementos dinámicos aparezcan
Sleep    5s

# Ahora interactuar con elementos nuevos
Wait Until Element Is Visible    xpath=//nuevo-elemento    20s
```

---

## 🛠️ Herramientas de Desarrollo

### Para Mapeo DOM:
1. **Playwright MCP Server** - Navegar e inspeccionar elementos en tiempo real
2. **DevTools del navegador** - Verificar selectores y estructura
3. **JavaScript en consola** - Extraer información detallada de elementos

### Comando JavaScript útil para extraer elementos:
```javascript
// Obtener todos los elementos de formulario con detalles
Array.from(document.querySelectorAll('form input, form select, form button')).map(el => ({
  tagName: el.tagName,
  id: el.id,
  className: el.className,
  name: el.name,
  type: el.type,
  outerHTML: el.outerHTML.slice(0, 200)
}))
```

---

## 📊 Caso de Éxito: Simulador de Crédito

### Elementos Mapeados Exitosamente:
- **Selector principal**: `id=selcProduct` con valor específico `9c3f41c9-446d-461b-a190-6747ff2cc879`
- **Campos de entrada**: `xpath=//input[@id='inputVivienda']`, `xpath=//input[@id='inputdinero']`
- **Selector de plazo**: `xpath=//select[@id='selectplazo']`
- **Método de pago**: `xpath=//div[@title='Frances']`
- **Botón acción**: `xpath=//button[@id='BtnSimu']`

### Flujo Probado:
1. Seleccionar "Hipotecario vivienda"
2. Esperar carga dinámica (5s)
3. Llenar valor vivienda ($80,000)
4. Llenar monto préstamo ($50,000)
5. Seleccionar plazo (120 meses)
6. Elegir método francés
7. Simular y validar resultados

---

## 🎯 Conclusiones

1. **Siempre mapear elementos reales** antes de escribir el script
2. **Usar selectores específicos** (IDs cuando sea posible)
3. **Implementar esperas robustas** en cada paso
4. **Considerar comportamientos dinámicos** de la aplicación
5. **Probar iterativamente** con scripts simples antes de completar

---

*Documento creado: Septiembre 25, 2025*  
*Proyecto: Automatización Simulador Crédito Banco Pichincha*  
*Herramientas: Robot Framework + Selenium + Playwright MCP*