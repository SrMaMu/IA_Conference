# 📋 BBVA-40 - Test Cases Creados en QMetry

## 🎯 Información General
- **Ticket JIRA:** BBVA-40
- **Descripción:** [Front][Android][iOS][GL][AR] Incorporar mancheta visa/mastercard
- **Fecha Creación:** ${new Date().toISOString().split('T')[0]}
- **Estado:** Test Cases Creados

## 📱 Test Cases Generados

### 1. BBVA-TC-47: Validar incorporación mancheta Visa en tarjetas móvil
- **ID QMetry:** gmRhnxr7h52qtM
- **Tipo:** exploratorio
- **Pasos:** 6
- **Estado:** ✅ Creado
- **Descripción:** Test case para validar la correcta incorporación de la mancheta Visa en las tarjetas dentro de la aplicación móvil BBVA Glomo

**Pasos del Test Case:**
1. Abrir aplicación BBVA Glomo en dispositivo Android
2. Ingresar credenciales válidas (DNI 10240480, usuario miusuario, password micd1122)
3. Navegar a la sección de tarjetas disponibles en el menú principal
4. Seleccionar una tarjeta de crédito Visa existente
5. Verificar que se muestra la mancheta Visa correctamente según diseño Figma
6. Tomar screenshot de la tarjeta con mancheta Visa visible

### 2. BBVA-TC-48: Validar incorporación mancheta Mastercard en tarjetas móvil
- **ID QMetry:** gxgntoKjcL1vJr
- **Tipo:** exploratorio
- **Pasos:** 6
- **Estado:** ✅ Creado
- **Descripción:** Test case para validar la correcta incorporación de la mancheta Mastercard en las tarjetas dentro de la aplicación móvil BBVA Glomo

**Pasos del Test Case:**
1. Abrir aplicación BBVA Glomo en dispositivo Android
2. Ingresar credenciales válidas (DNI 10240480, usuario miusuario, password micd1122)
3. Navegar a la sección de tarjetas disponibles en el menú principal
4. Seleccionar una tarjeta de crédito Mastercard existente
5. Verificar que se muestra la mancheta Mastercard correctamente según diseño
6. Tomar screenshot de la tarjeta con mancheta Mastercard visible

## 🔗 Próximos Pasos
1. ✅ Test Cases creados en QMetry
2. 🔄 **En Progreso:** Ejecución híbrida móvil + web
3. ⏳ Pendiente: Automatización Robot Framework
4. ⏳ Pendiente: Generación de reportes ejecutivos

## 📊 Métricas
- **Test Cases Totales:** 2
- **Plataformas Cubiertas:** Móvil (Android/iOS)
- **Tipos de Mancheta:** Visa, Mastercard
- **Validaciones por TC:** 6 pasos cada uno

---
*Generado automáticamente por BBVA E2E Workflow - ${new Date().toISOString()}*