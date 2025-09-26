# Instrucciones para Trabajar con QMetry - Test Cases

## 📋 Información del Proyecto Estándar

Para todos los test cases, siempre utilizaremos el proyecto:

- **ID del Proyecto:** `10004`
- **Clave del Proyecto:** `IAC`  
- **Nombre del Proyecto:** `IA Conference 2025`

> ⚠️ **IMPORTANTE:** Este proyecto está sincronizado con el proyecto JIRA IAC, manteniendo consistencia entre tickets JIRA y test cases QMetry.

## 🔧 Configuración Previa Requerida

### 1. Variable de Entorno
```powershell
# Verificar que QMETRY_API_KEY esté configurada
echo $env:QMETRY_API_KEY
```

### 2. Configuración de Headers para API
```powershell
$headers = @{ 
    "Content-Type" = "application/json"; 
    "apikey" = "$env:QMETRY_API_KEY" 
}
```

### 3. URL Base de la API
- **URL:** `https://qtmcloud.qmetry.com/rest/api/latest/`

## 📂 Paso a Paso: Gestión de Test Cases

### Paso 1: Verificar Proyectos Disponibles
```powershell
# Listar todos los proyectos QMetry disponibles
$body = '{"search": "", "maxResults": 100}'
$result = Invoke-RestMethod -Uri "https://qtmcloud.qmetry.com/rest/api/latest/projects" -Method POST -Headers $headers -Body $body
$result.data | ForEach-Object { Write-Host "ID: $($_.id) | Key: $($_.key) | Nombre: $($_.name)" }
```

### Paso 2: Listar Carpetas de Test Cases del Proyecto IAC
```powershell
# Obtener estructura de carpetas en el proyecto IAC (ID: 10004)
$body = '{"projectId": 10004}'
$folders = Invoke-RestMethod -Uri "https://qtmcloud.qmetry.com/rest/api/latest/testcasefolders" -Method POST -Headers $headers -Body $body
$folders.data | ForEach-Object { Write-Host "Folder ID: $($_.id) | Nombre: $($_.name) | Parent: $($_.parentId)" }
```

### Paso 3: Crear Test Case en el Proyecto IAC
```powershell
# Estructura básica para crear test case (endpoint correcto)
$testCaseBody = @{
    projectId = "10004"
    folderId = "-1"  # -1 para carpeta raíz, o usar ID específico de carpeta
    summary = "Nombre del Test Case"
    description = "Descripción detallada del test case"
    steps = @(
        @{
            stepDetails = "Descripción del paso"
            testData = "Datos de prueba necesarios"
            expectedResult = "Resultado esperado"
            id = 1
        }
    )
} | ConvertTo-Json -Depth 10

$newTestCase = Invoke-RestMethod -Uri "https://qtmcloud.qmetry.com/rest/api/latest/testcases/" -Method POST -Headers $headers -Body $testCaseBody
```

### Paso 4: Listar Test Cases Existentes

```powershell
# Buscar test cases en el proyecto IAC (forma correcta)
$searchBody = '{"filter": {"projectId": 10004}}'
$testCases = Invoke-RestMethod -Uri "https://qtmcloud.qmetry.com/rest/api/latest/testcases/search/" -Method POST -Headers $headers -Body $searchBody
$testCases.data | ForEach-Object { Write-Host "Key: $($_.key) | Summary: $($_.summary)" }
```

## 🎯 Metodología de Trabajo

### Integración con JIRA IAC

1. **Coherencia de Proyectos:** 
   - JIRA: Proyecto `IAC`
   - QMetry: Proyecto `IAC (ID: 10004)`

2. **Flujo de Trabajo:**
   - Crear tickets JIRA usando `JIRA_CrearNuevosIssues.prompt.md`
   - Crear test cases QMetry relacionados usando estas instrucciones
   - Mantener trazabilidad entre tickets y test cases

3. **Nomenclatura Estándar:**
   - Test cases deben referenciar tickets JIRA cuando corresponda
   - Usar prefijos consistentes (ej: "TC_IAC-XX_")

### Tipos de Test Cases a Crear

#### 1. Testing Exploratorio
- **Objetivo:** Validar funcionalidades manualmente
- **Carpeta sugerida:** "Testing Exploratorio"
- **Pasos típicos:** Navegación, validación de UI, flujos de usuario

#### 2. Automatización con Robot Framework
- **Objetivo:** Test cases para automatizar con Robot Framework
- **Carpeta sugerida:** "Automatización"
- **Pasos típicos:** Selectores web, validaciones automatizables

#### 3. Testing de Regresión
- **Objetivo:** Validar que no se rompan funcionalidades existentes
- **Carpeta sugerida:** "Regresión"
- **Pasos típicos:** Casos críticos del sistema

## 🔍 Plantillas de Test Cases

### Plantilla: Test Case Exploratorio
```json
{
    "projectId": "10004",
    "folderId": "-1",
    "summary": "Validar [Funcionalidad] - [Escenario]",
    "description": "Objetivo: Verificar que [funcionalidad] funciona correctamente en el escenario [x]",
    "steps": [
        {
            "stepDetails": "Navegar a [URL o página]",
            "testData": "URL: [url específica]",
            "expectedResult": "La página se carga correctamente",
            "id": 1
        },
        {
            "stepDetails": "Ejecutar [acción específica]",
            "testData": "[datos de entrada]",
            "expectedResult": "[resultado esperado]",
            "id": 2
        }
    ]
}
```

### Plantilla: Test Case para Automatización
```json
{
    "projectId": "10004",
    "folderId": "-1", 
    "summary": "AUTO - [Funcionalidad] - [Escenario]",
    "description": "Test case diseñado para automatización con Robot Framework",
    "steps": [
        {
            "stepDetails": "Abrir navegador y navegar a [URL]",
            "testData": "Browser: Chrome, URL: [url]",
            "expectedResult": "Página cargada exitosamente",
            "id": 1
        },
        {
            "stepDetails": "Localizar elemento usando selector [selector]",
            "testData": "Selector: [xpath o css selector]",
            "expectedResult": "Elemento encontrado y visible",
            "id": 2
        }
    ]
}
```

## ⚠️ Troubleshooting

### Error "Invalid projectId"
- **Causa:** ID de proyecto incorrecto
- **Solución:** Verificar que se usa `10004` para proyecto IAC

### Error "Folder not found"
- **Causa:** folderId incorrecto
- **Solución:** Usar `-1` para carpeta raíz o listar carpetas primero

### Error de Autenticación
- **Causa:** API key incorrecta o expirada
- **Solución:** Verificar `$env:QMETRY_API_KEY`

## 🔗 Referencias

- **Proyecto JIRA:** IAC
- **Proyecto QMetry:** IA Conference 2025 (ID: 10004)
- **Prompt JIRA relacionado:** `JIRA_CrearNuevosIssues.prompt.md`
- **API QMetry:** https://qtmcloud.qmetry.com/rest/api/latest/


**Última actualización:** 25 de Septiembre, 2025
**Autor:** Proceso de configuración automatizado MCP QMetry


# 📈 Casos de Éxito y Manual de Procedimiento

## 1. Búsqueda de Proyectos QMetry

**Comando probado y exitoso:**
```powershell
$body = '{"search": "", "maxResults": 100}'
$result = Invoke-RestMethod -Uri "https://qtmcloud.qmetry.com/rest/api/latest/projects" -Method POST -Headers $headers -Body $body
$result.data | ForEach-Object { Write-Host "ID: $($_.id) | Key: $($_.key) | Nombre: $($_.name)" }
```
**Resultado esperado:** Listado de todos los proyectos disponibles, incluyendo el proyecto IAC (ID: 10004).

## 2. Creación de Carpetas (por épica)

**Comando probado y exitoso:**
```powershell
$folderBody = '{"folderName": "Epica 1 - Configuracion Inicial", "description": "Test cases para la configuracion inicial", "parentId": "-1"}'
$result = Invoke-RestMethod -Uri "https://qtmcloud.qmetry.com/rest/api/latest/projects/10004/testcase-folders" -Method POST -Headers $headers -Body $folderBody
```
**Resultado esperado:** Carpeta creada correctamente, visible en el front de QMetry.

## 3. Creación de Test Cases

**Comando probado y exitoso:**
```powershell
$testCase = '{"summary": "TC001 - Verificar Login Sistema", "projectId": "10004", "folderId": "2045448", "description": "Test de login basico", "steps": [{"stepDetails": "Ingresar usuario y contraseña", "testData": "usuario demo", "expectedResult": "Login exitoso", "id": 1}]}'
$result = Invoke-RestMethod -Uri "https://qtmcloud.qmetry.com/rest/api/latest/testcases/" -Method POST -Headers $headers -Body $testCase
```
**Resultado esperado:** Test case creado correctamente y visible en la carpeta correspondiente.

## 4. Vinculación de Test Cases a Issues de JIRA

**Procedimiento recomendado:**
1. Crear el test case en QMetry incluyendo en el campo `summary` o `description` la clave del issue de JIRA (ejemplo: "Relacionado a IAC-123").
2. Desde el front de QMetry, utilizar la funcionalidad de "Link to JIRA Issue" para asociar el test case al ticket correspondiente.
3. Verificar que la vinculación sea visible tanto en QMetry como en JIRA.

**Nota:** La vinculación directa por API puede requerir permisos y endpoints adicionales. El método manual desde el front es el más confiable y probado.

---
**Resumen:**
- Todos los comandos anteriores han sido probados y validados con éxito.
- El procedimiento documentado permite crear y organizar test cases de manera estructurada y asociarlos a issues de JIRA para trazabilidad.

## 🚀 Opción: Creación de Carpetas en QMetry mediante Script TypeScript (API MCP)

Además de los métodos manuales y PowerShell, puedes crear carpetas en QMetry de forma automatizada usando un script TypeScript que consuma directamente la API MCP del proyecto. Este método es útil cuando:
- El servidor MCP está corriendo y tienes acceso al código fuente del proyecto.
- Quieres crear varias carpetas de manera programática, por ejemplo, a partir de épicas de JIRA.
- Necesitas garantizar que los nombres y descripciones sean exactamente los requeridos (sin prefijos ni sufijos extra).

### ¿Cuándo aplica?
- **Sí aplica**: Si tienes acceso al código y puedes ejecutar scripts Node.js/TypeScript en el entorno del MCP server.
- **No aplica**: Si solo tienes acceso a la interfaz web de QMetry o no puedes ejecutar scripts en el entorno del servidor MCP.

### Ejemplo de uso
1. Crea un archivo `crear_carpetas_epicas.ts` en la carpeta `src/` del proyecto MCP con el siguiente contenido:

```typescript
import { createQmetryTestCaseFolder } from './api/qmetry-test-case-folders';

async function main() {
  // Carpeta 1
  await createQmetryTestCaseFolder(
    'Testing Exploratorio y Accesibilidad Web',
    '-1',
    '10004',
    'Épica para agrupar todos los tickets relacionados con testing exploratorio, pruebas de accesibilidad y análisis de usabilidad en diferentes aplicaciones web.'
  );

  // Carpeta 2
  await createQmetryTestCaseFolder(
    'Simulación de Créditos Bancarios',
    '-1',
    '10004',
    'Épica para agrupar todos los tickets relacionados con el relevamiento, análisis y testing de funcionalidades de simulación de créditos bancarios.'
  );
}

main().catch(console.error);
```

2. Navega a la carpeta `src` y ejecuta el script:

```powershell
cd jira-qmetry-mcp/src
npx tsx crear_carpetas_epicas.ts
```

3. Verifica en QMetry que las carpetas se hayan creado correctamente, con los nombres y descripciones exactos.

> **Importante:**
> - Usa siempre los nombres y descripciones que correspondan a las épicas o requerimientos del proyecto, sin agregar prefijos automáticos ni modificar el formato.
> - Este método es ideal para flujos automatizados y garantiza trazabilidad entre JIRA y QMetry.

---