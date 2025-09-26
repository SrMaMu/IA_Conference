# Exploración y Análisis de Accesibilidad: https://epamneoris.com/about

## 1. Estructura General y Links Principales
- Menú principal con enlaces a: Careers, Community, About, Media, Industries, Solutions.
- Secciones principales: Banner, "Who we are", "Vision", "Mission", premios y reconocimientos, links a políticas y ética.

## 2. Paso a Paso de Interacciones Reales
### 2.1. Navegación inicial
- Se accede a https://epamneoris.com/about
- Página carga correctamente, sin popups intrusivos.
- Menú principal visible y navegable por teclado.

### 2.2. Exploración de secciones
- Banner principal con imagen y mensaje.
- Sección "Who we are" con descripción de la empresa y video de YouTube embebido.
- Sección "Vision" y "Mission" con textos claros y destacados.
- Premios y reconocimientos: SAP Pinnacle Award, Frost & Sullivan, Forrester.
- Links a documentos de calidad, ética y políticas.

### 2.3. Interacciones funcionales
- Se navega con teclado por el menú y se accede a cada sección.
- Se prueba el acceso a links externos (YouTube, documentos PDF, sitios de ética y políticas).
- Se verifica que los links abren en nueva pestaña y tienen foco visible.

## 3. Análisis de Accesibilidad
- Todos los links del menú tienen foco visible.
- Imágenes principales tienen atributo alt.
- El contraste de colores es adecuado en textos principales.
- El sitio es navegable por teclado.
- Se detecta error de JavaScript en consola y un recurso de fontawesome bloqueado (403), pero no afecta la navegación.

## 4. Issues Encontrados
- [Menor] Error de JavaScript en consola: "Cannot read properties of null (reading 'addEventListener')".
- [Menor] Recurso de fontawesome bloqueado (403) en consola.
- No se detectan issues críticos de accesibilidad ni funcionalidad.

## 5. Flujo Funcional Principal (Test Case)
**Objetivo:** Validar navegación completa y acceso a recursos externos.

**Pasos:**
1. Ingresar a https://epamneoris.com/about
2. Navegar por el menú usando teclado y acceder a cada sección principal.
3. Acceder a los links de video, documentos y ética.
4. Verificar que los links abren correctamente y tienen foco visible.

**Resultado esperado:**
- Todas las secciones y recursos externos son accesibles.
- No se detectan errores críticos.

## 6. Issues documentados
- [Menor] Error de JavaScript en consola, sin impacto funcional.
- [Menor] Recurso de fontawesome bloqueado, sin impacto funcional.

## 7. Estado
- Test exploratorio y de accesibilidad satisfactorio. Sin issues críticos.
- Listo para crear ticket en JIRA y subir reporte a Confluence.
