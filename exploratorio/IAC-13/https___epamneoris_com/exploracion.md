# Exploración y Análisis de Accesibilidad: https://epamneoris.com/

## 1. Estructura General y Links Principales
- Menú principal con enlaces a: Careers, Community, About, Media, Industries, Solutions.
- Secciones principales: Banner, Servicios, Historias de Éxito, Formulario de Contacto, Footer con links legales y redes sociales.

## 2. Paso a Paso de Interacciones Reales
### 2.1. Navegación inicial
- Se accede a la home: https://epamneoris.com/
- Se observa carga rápida, sin popups intrusivos.
- Menú principal visible en la parte superior.

### 2.2. Exploración del menú principal
- Se identifican los siguientes links:
  - Careers: https://careers.neoris.com/
  - Community: /events
  - About: /about
  - Media: /media
  - Industries: /industries
  - Solutions: /solutions
- Se verifica que todos los links son accesibles mediante tabulación y tienen foco visible.

### 2.3. Navegación por secciones
- Banner principal con mensaje y video (mensaje alternativo si el navegador no soporta video).
- Sección "Our Services" con 6 servicios destacados, cada uno con título, imagen y descripción.
- Sección "Success Stories" con 3 casos destacados y link a todos los casos.
- Formulario de contacto con campos obligatorios: Nombre, Apellido, Email, Empresa, Mensaje.
- Footer con links a redes sociales y políticas legales.

### 2.4. Interacciones funcionales
- Se navega con teclado por el menú y se accede a cada sección.
- Se prueba el formulario de contacto: se valida que los campos obligatorios muestran error si están vacíos.
- Se navega a "Careers" y se verifica redirección correcta.
- Se navega a "About", "Media", "Industries", "Solutions" y se valida carga de cada página.

## 3. Análisis de Accesibilidad
- Todos los links del menú tienen foco visible.
- Imágenes principales tienen atributo alt.
- El formulario de contacto tiene labels asociados a cada input.
- El contraste de colores es adecuado en textos principales.
- El sitio es navegable por teclado.
- Se detecta un mensaje de error en consola relacionado a un script nulo, pero no afecta la navegación.

## 4. Issues Encontrados
- [Menor] Error de JavaScript en consola: "Cannot read properties of null (reading 'addEventListener')".
- No se detectan issues críticos de accesibilidad ni funcionalidad.

## 5. Flujo Funcional Principal (Test Case)
**Objetivo:** Validar navegación completa y envío de formulario de contacto.

**Pasos:**
1. Ingresar a https://epamneoris.com/
2. Navegar por el menú usando teclado y acceder a cada sección principal.
3. Completar el formulario de contacto con datos válidos y enviarlo.
4. Verificar mensajes de validación si algún campo está vacío.
5. Acceder a "Careers" y validar redirección.
6. Acceder a "About", "Media", "Industries", "Solutions" y validar carga.

**Resultado esperado:**
- Todas las páginas cargan correctamente.
- El formulario valida campos obligatorios y permite envío.
- No se detectan errores críticos.

## 6. Issues documentados
- [Menor] Error de JavaScript en consola, sin impacto funcional.

## 7. Estado
- Test exploratorio y de accesibilidad satisfactorio. Sin issues críticos.
- Listo para crear ticket en JIRA y subir reporte a Confluence.
