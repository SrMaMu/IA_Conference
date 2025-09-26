# Exploración y Análisis de Accesibilidad: https://epamneoris.com/media

## 1. Estructura General y Links Principales
- Menú principal con enlaces a: Careers, Community, About, Media, Industries, Solutions.
- Secciones principales: Banner, listado de artículos (blog), categorías, destacados, más vistos, footer con links legales y redes sociales.

## 2. Paso a Paso de Interacciones Reales
### 2.1. Navegación inicial
- Se accede a https://epamneoris.com/media
- Página carga correctamente, sin popups intrusivos.
- Menú principal visible y navegable por teclado.

### 2.2. Exploración de secciones
- Banner principal con título "BLOG | NEORIS".
- Listado de artículos con imagen, título, fecha y resumen.
- Filtros por categoría, palabra clave y fecha.
- Sección de artículos destacados y más vistos.
- Footer con links legales y redes sociales.

### 2.3. Interacciones funcionales
- Se navega con teclado por el menú y se accede a cada sección.
- Se prueba el acceso a artículos, filtros y paginación.
- Se verifica que los links abren correctamente y tienen foco visible.

## 3. Análisis de Accesibilidad
- Todos los links del menú tienen foco visible.
- Imágenes principales tienen atributo alt.
- El contraste de colores es adecuado en textos principales.
- El sitio es navegable por teclado.
- Se detecta error de JavaScript en consola, pero no afecta la navegación.

## 4. Issues Encontrados
- [Menor] Error de JavaScript en consola: "Cannot read properties of null (reading 'addEventListener')".
- No se detectan issues críticos de accesibilidad ni funcionalidad.

## 5. Flujo Funcional Principal (Test Case)
**Objetivo:** Validar navegación por artículos y uso de filtros.

**Pasos:**
1. Ingresar a https://epamneoris.com/media
2. Navegar por el menú usando teclado y acceder a cada sección principal.
3. Acceder a varios artículos y validar carga.
4. Utilizar filtros de categoría y paginación.
5. Verificar que los links abren correctamente y tienen foco visible.

**Resultado esperado:**
- Todas las secciones y artículos son accesibles.
- Filtros y paginación funcionan correctamente.
- No se detectan errores críticos.

## 6. Issues documentados
- [Menor] Error de JavaScript en consola, sin impacto funcional.

## 7. Estado
- Test exploratorio y de accesibilidad satisfactorio. Sin issues críticos.
- Listo para crear ticket en JIRA y subir reporte a Confluence.
