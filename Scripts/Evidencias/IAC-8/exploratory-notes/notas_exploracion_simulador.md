# Notas Exploratorias - IAC-8
## Simulador de Crédito Banco Pichincha

### 📅 Sesión de Testing Exploratorio
- **Fecha:** 25 de Septiembre de 2025
- **Duración:** ~25 minutos
- **Herramientas:** Playwright MCP Server
- **Enfoque:** Funcionalidad del simulador de crédito

### 🔍 Proceso de Mapeo y Exploración

#### Fase 1: Carga Inicial y Reconocimiento
- **URL accedida:** https://www.pichincha.com/detalle-producto/simulador-de-credito
- **Tiempo de carga:** ~5 segundos
- **Elemento clave identificado:** `id=selcProduct` (selector principal)

#### Fase 2: Mapeo de Elementos DOM
```javascript
// Elementos identificados durante exploración:
id=selcProduct                    // Selector tipo de crédito
xpath=//input[@id='inputVivienda'] // Campo valor vivienda  
xpath=//input[@id='inputdinero']   // Campo monto préstamo
xpath=//select[@id='selectplazo']  // Selector de plazo
xpath=//div[@title='Frances']      // Método francés
xpath=//button[@id='BtnSimu']      // Botón simular
```

#### Fase 3: Comportamientos Dinámicos Observados
1. **Carga inicial:** Formulario parcialmente deshabilitado
2. **Selección tipo crédito:** Activa campos dinámicamente (delay ~5s)
3. **Campos de entrada:** Requieren clic para activación completa
4. **Validaciones:** Campo mínimo $3.000 validado automáticamente
5. **Cálculo:** Botón se habilita tras completar todos los campos

### 🧪 Datos de Prueba Utilizados

#### Conjunto de Datos Exitoso:
- **Tipo:** Hipotecario vivienda (ID: `9c3f41c9-446d-461b-a190-6747ff2cc879`)
- **Valor vivienda:** $80.000,00
- **Monto préstamo:** $50.000,00  
- **Plazo:** 120 meses (10.0 años)
- **Método:** Francés

#### Validaciones Realizadas:
- ✅ Campos aceptan valores numéricos correctamente
- ✅ Dropdown de plazo funciona sin errores
- ✅ Método de amortización se selecciona correctamente
- ✅ Botón "Simular" se habilita al completar formulario

### 💰 Resultados de la Simulación

#### Cálculo Exitoso Obtenido:
- **Cuota mensual total:** $694,83
- **Desglose:** Capital $233,69 + Interés $419,58 + Seguro $41,56
- **Tasa aplicada:** 10.07%
- **Total a pagar:** $83.379,63

#### Validaciones del Resultado:
- ✅ Valores numéricos consistentes y lógicos  
- ✅ Desglose detallado mostrado correctamente
- ✅ Información completa y clara para el usuario
- ✅ Sin errores en cálculos matemáticos

### 🐛 Problemas Técnicos Encontrados

#### Errores JavaScript (No bloqueantes):
```javascript
// Errores observados en consola:
- TypeError: Cannot read properties of null (reading 'addEventListener')
- Attestation check for Attribution Reporting failed
```
- **Impacto:** No afectan funcionalidad principal del simulador
- **Estado:** Errores de terceros (Facebook tracking, etc.)

#### Comportamientos Especiales:
- **Delay dinámico:** Campos aparecen con retraso tras selección inicial
- **Activación requerida:** Campos necesitan clic explícito para habilitarse
- **Validación automática:** Mínimos y máximos validados en tiempo real

### 📋 Elementos Técnicos Críticos

#### Selectores Probados y Validados:
```robot
# ✅ Funcionales y confiables:
id=selcProduct                         # Selector principal
xpath=//input[@id='inputVivienda']     # Campo vivienda
xpath=//input[@id='inputdinero']       # Campo préstamo  
xpath=//select[@id='selectplazo']      # Selector plazo
xpath=//div[@title='Frances']          # Método amortización
xpath=//button[@id='BtnSimu']          # Botón acción

# ❌ Problemáticos (evitar):
xpath=//select                         # Muy genérico
xpath=//input[@placeholder='Ej. $1000'] # No único
```

#### Tiempos de Espera Recomendados:
- **Carga inicial:** 30s
- **Elementos dinámicos:** 20s  
- **Entre acciones:** 3-5s
- **Estabilización post-clic:** 2s

### 💡 Lecciones Aprendidas

#### Estrategias Exitosas:
1. **Mapeo previo:** Usar Playwright para identificar elementos reales
2. **Selectores específicos:** Priorizar IDs sobre XPath genéricos  
3. **Esperas robustas:** Implementar timeouts apropiados
4. **Activación explícita:** Hacer clic en campos antes de llenar

#### Patrones de Automatización:
```robot
# Patrón robusto identificado:
Wait Until Element Is Visible    xpath=//elemento    20s
Wait Until Element Is Enabled    xpath=//elemento    20s  
Click Element                    xpath=//elemento
Sleep                           2s
Input Text                      xpath=//elemento    valor
```

### ✅ Conclusiones Finales

#### Funcionalidad Validada:
- ✅ Simulador completamente operativo
- ✅ Cálculos financieros precisos
- ✅ Interfaz de usuario intuitiva
- ✅ Elementos DOM estables y mapeables

#### Automatización Viable:
- ✅ Elementos identificables de forma única
- ✅ Comportamientos predecibles
- ✅ Flujo end-to-end funcional
- ✅ Resultados verificables

#### Próximos Pasos:
- Script Robot Framework generado y funcional
- Template reutilizable para casos similares
- Selectores documentados para mantenimiento futuro