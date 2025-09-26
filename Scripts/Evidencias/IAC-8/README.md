# IAC-8 - Simulador de Crédito Banco Pichincha

## 📋 Resumen de Ejecución

- **Ticket JIRA:** IAC-8  
- **Fecha de Ejecución:** 25 de Septiembre de 2025
- **Analista:** Matias Munoz
- **URL Probada:** https://www.pichincha.com/detalle-producto/simulador-de-credito
- **Estado Final:** ✅ EXITOSO

## 🎯 Caso de Prueba Ejecutado

### TC001: Calcular cuota mensual con datos válidos
- **Estado:** ✅ PASÓ
- **Descripción:** Simulación de crédito hipotecario con datos válidos
- **Datos de Prueba:**
  - Tipo: Hipotecario vivienda
  - Valor vivienda: $80.000,00
  - Monto a financiar: $50.000,00
  - Plazo: 120 meses (10 años)
  - Método: Francés

## 💰 Resultados Financieros Obtenidos

### Cuota Mensual: **$694,83**
- **Capital mensual:** $233,69
- **Interés mensual:** $419,58
- **Seguro mensual:** $41,56

### Desglose Total del Crédito:
- **Capital:** $49.750,00
- **Total intereses:** $29.793,98
- **Total seguro desgravamen:** $1.554,80
- **Total a pagar:** $83.379,63
- **Tasa de interés:** 10.07%

## 📊 Métricas de Ejecución

- **Total Test Cases:** 1
- **Ejecutados:** 1
- **Pasaron:** 1 (100%)
- **Fallaron:** 0
- **Duración Total:** ~5 minutos

## 📸 Evidencias Disponibles

### Screenshots
- `IAC-8_TC001_resultado_simulacion.png` - Captura con resultados completos

### Logs
- Logs de ejecución Playwright disponibles en carpeta `/logs/`

### Datos de Prueba
- Archivo CSV con datos utilizados en `/test-data/`

## 🔍 Hallazgos Técnicos

### Elementos DOM Mapeados:
- **Selector de tipo:** `id=selcProduct` (valor: `9c3f41c9-446d-461b-a190-6747ff2cc879`)
- **Campo valor vivienda:** `xpath=//input[@id='inputVivienda']`
- **Campo monto préstamo:** `xpath=//input[@id='inputdinero']`
- **Selector de plazo:** `xpath=//select[@id='selectplazo']`
- **Método amortización:** `xpath=//div[@title='Frances']`
- **Botón simular:** `xpath=//button[@id='BtnSimu']`

### Comportamientos Identificados:
- ✅ Formulario se habilita dinámicamente tras seleccionar tipo de crédito
- ✅ Campos requieren clic para activación completa
- ✅ Cálculo se ejecuta correctamente sin errores
- ✅ Resultados se muestran de forma clara y detallada

## 🤖 Artefactos Generados

- **Script Robot Framework:** `/Scripts/IAC-8.robot`
- **Keywords específicos:** Disponibles para reutilización
- **Selectores validados:** Elementos del simulador mapeados
- **Datos de prueba:** Template para futuras ejecuciones

## ✅ Resultado Final

**SIMULACIÓN EJECUTADA EXITOSAMENTE CON RESULTADOS VÁLIDOS**

El simulador de crédito de Banco Pichincha funciona correctamente y genera cálculos financieros precisos según los criterios establecidos.