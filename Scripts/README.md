# Scripts de Automatización - Proyecto IAC

## 📋 Descripción General

Esta carpeta contiene todos los scripts automatizados de Robot Framework generados a partir del proceso de testing exploratorio con Playwright para el proyecto IAC (Internal Application Console).

## 📁 Estructura de Carpetas

```
/Scripts/
├── README.md                    # Este archivo
├── {TICKET-ID}.robot           # Scripts automatizados por ticket
├── /Evidencias/                # Carpeta principal de evidencias
│   └── /{TICKET-ID}/           # Una carpeta por ticket ejecutado
│       ├── /screenshots/       # Capturas de pantalla
│       ├── /logs/              # Logs de ejecución  
│       ├── /exploratory-notes/ # Notas del trabajo exploratorio
│       ├── /test-data/         # Datos de prueba utilizados
│       └── README.md           # Resumen ejecutivo del ticket
```

## 🤖 Scripts Disponibles

### IAC-10.robot - Pruebas de Accesibilidad Argentina.gob.ar
- **URL:** https://www.argentina.gob.ar/
- **Funcionalidad:** Validación de accesibilidad y navegación
- **Test Cases:** 2 (TC001: Navegación, TC002: Documentación)
- **Estado:** ✅ Funcional y validado

### IAC-8.robot - Simulador de Crédito Banco Pichincha  
- **URL:** https://www.pichincha.com/detalle-producto/simulador-de-credito
- **Funcionalidad:** Automatización de cálculo de crédito hipotecario
- **Test Cases:** 1 (TC001: Calcular cuota mensual)
- **Estado:** ✅ Funcional y validado

## 🔧 Prerequisitos para Ejecución

### Dependencias Requeridas:
```bash
# Robot Framework y librerías
pip install robotframework
pip install robotframework-seleniumlibrary

# WebDriver (Chrome recomendado)
# Descargar ChromeDriver compatible con versión del navegador
```

### Configuración de Ambiente:
```robot
# Variables globales recomendadas
${BROWSER}          Chrome
${TIMEOUT}          30s
${SCREENSHOT_DIR}   Scripts/Evidencias/{TICKET-ID}/screenshots
```

## 🚀 Ejecución de Scripts

### Ejecutar script individual:
```bash
# Ejecutar IAC-10
robot Scripts/IAC-10.robot

# Ejecutar IAC-8  
robot Scripts/IAC-8.robot
```

### Ejecutar todos los scripts:
```bash
# Ejecutar toda la suite
robot Scripts/*.robot
```

### Generar reportes detallados:
```bash
# Con reportes HTML
robot --outputdir results Scripts/*.robot
```

## 📊 Métricas de Testing

### Resumen de Ejecuciones:
- **Total Scripts:** 2
- **Total Test Cases:** 3
- **Tasa de Éxito:** 100%
- **Cobertura:** Accesibilidad + Funcional

### Tiempo de Ejecución Promedio:
- **IAC-10:** ~3 minutos
- **IAC-8:** ~5 minutos
- **Suite completa:** ~8 minutos

## 🧪 Proceso de Generación

### 1. Testing Exploratorio con Playwright
- Mapeo manual de elementos DOM
- Identificación de comportamientos dinámicos  
- Validación de funcionalidades end-to-end
- Captura de evidencias y screenshots

### 2. Análisis y Documentación
- Extracción de selectores robustos
- Documentación de tiempos de espera
- Identificación de datos de prueba
- Creación de notas exploratorias

### 3. Generación de Scripts Robot Framework
- Conversión de acciones Playwright → Robot Keywords
- Implementación de esperas y validaciones
- Organización en estructura Gherkin
- Validación de funcionamiento

### 4. Organización de Evidencias
- Carpetas estructuradas por ticket
- Screenshots organizados y nombrados
- Logs detallados de ejecución
- Documentación completa del proceso

## 🔍 Patrones y Mejores Prácticas

### Selectores Utilizados:
```robot
# ✅ Preferir IDs directos
id=elementId

# ✅ XPath con atributos únicos  
xpath=//input[@id='specificId']
xpath=//div[@title='uniqueTitle']

# ❌ Evitar selectores genéricos
xpath=//select
xpath=//input[@placeholder='generic']
```

### Estructura de Keywords:
```robot
# Patrón robusto implementado:
Wait Until Element Is Visible    ${SELECTOR}    ${TIMEOUT}
Wait Until Element Is Enabled    ${SELECTOR}    ${TIMEOUT}
Click Element                    ${SELECTOR}
Sleep                           2s
Input Text                      ${SELECTOR}    ${VALUE}
```

## 📚 Referencias y Documentación

### Archivos de Referencia:
- **Proceso completo:** `/.github/prompts/JIRA_EjecutarTestsCompletos.prompt.md`
- **Guía Robot Framework:** `/.github/instructions/RobotFramework.instructions.md`
- **Evidencias detalladas:** `/Scripts/Evidencias/{TICKET-ID}/README.md`

### Links Útiles:
- [Robot Framework Documentation](https://robotframework.org/robotframework/)
- [SeleniumLibrary Keywords](https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html)
- [Playwright MCP Server](https://github.com/microsoft/playwright)

## 🔄 Mantenimiento y Actualizaciones

### Cuando actualizar scripts:
- Cambios en la interfaz de usuario de las aplicaciones
- Modificaciones en selectores DOM
- Nuevos casos de prueba identificados
- Optimizaciones de performance

### Versionado:
- Scripts versionados por fecha de generación
- Evidencias archivadas por ejecución
- Histórico de cambios en notas exploratorias

---

**Generado:** 25 de Septiembre de 2025  
**Metodología:** Testing Exploratorio + Robot Framework  
**Herramientas:** Playwright MCP + SeleniumLibrary  
**Proyecto:** IAC (Internal Application Console)