# Exploración y Análisis de Accesibilidad: https://www.mercadolibre.com/

## 1. Estructura General y Links Principales
- Banner principal con logo y título "MercadoLibre".
- Menú de navegación con links a países de Latinoamérica.

## 2. Paso a Paso de Interacciones Reales
### 2.1. Navegación inicial
- Se accede a https://www.mercadolibre.com/
- Página carga correctamente, sin popups intrusivos.
- Menú de países visible y navegable por teclado.

### 2.2. Exploración de secciones
- Se navega por el menú de países usando tabulación.
- Se accede a los links de Argentina, Brasil, México, Chile, Colombia, etc.
- Se verifica que los links abren correctamente y tienen foco visible.

### 2.3. Interacciones funcionales
- Se selecciona un país (por ejemplo, Argentina) y se valida la redirección.
- Se navega de regreso a la home y se prueba otro país.

## 3. Análisis de Accesibilidad
- Todos los links del menú tienen foco visible.
- El contraste de colores es adecuado en textos principales.
- El sitio es navegable por teclado.
- Se detectan advertencias de Content Security Policy en consola, pero no afectan la navegación.

## 4. Issues Encontrados
- [Menor] Advertencias de Content Security Policy en consola.
- No se detectan issues críticos de accesibilidad ni funcionalidad.

## 5. Flujo Funcional Principal (Test Case)
**Objetivo:** Validar navegación por menú de países y redirección.

**Pasos:**
1. Ingresar a https://www.mercadolibre.com/
2. Navegar por el menú usando teclado y acceder a varios países.
3. Validar la redirección a la home del país seleccionado.
4. Verificar que los links abren correctamente y tienen foco visible.

**Resultado esperado:**
- Todos los links de países son accesibles.
- Redirección funciona correctamente.
- No se detectan errores críticos.

## 6. Issues documentados
- [Menor] Advertencias de Content Security Policy, sin impacto funcional.

## 7. Estado
- Test exploratorio y de accesibilidad satisfactorio. Sin issues críticos.
- Listo para crear ticket en JIRA y subir reporte a Confluence.
