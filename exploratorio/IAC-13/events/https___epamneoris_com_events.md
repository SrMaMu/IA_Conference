# Exploración y Accesibilidad: https___epamneoris_com_events.md

Este archivo corresponde al testing exploratorio y de accesibilidad realizado sobre la URL https://epamneoris.com/events.

## 1. Estructura principal de la URL
- Página de eventos y comunidad de EPAM NEORIS.
- Banner superior con menú principal.
- Listado de eventos destacados con título, ubicación, descripción y links a más información.
- Pie de página con links institucionales y redes sociales.

## 2. Links principales
- Menú: Careers, Community, About, Media, Industries, Solutions
- Eventos destacados: cada uno con link "Read more" a detalle
- Registro a eventos ("Registro", "Be our guest. RSVP today")
- Links a redes sociales: LinkedIn, Facebook, Twitter, Instagram, YouTube
- Links institucionales: Privacy Policy, Legal Notice, Infosec Policy Abstract, Policy for Contractors, Sitemap

## 3. Funcionalidad principal (aparente)
- Visualización de eventos y actividades de la comunidad.
- Acceso a información detallada de cada evento.
- Posibilidad de registro a eventos.

## 4. Paso a paso de tareas realizadas
1. Navegación inicial a https://epamneoris.com/events.
2. Se visualiza el listado de eventos destacados.
3. Se hace clic en el link "Read more" del primer evento destacado (Innovation Day Madrid).
   - Resultado: Se accede correctamente a la página de detalle del evento (https://epamneoris.com/-/epam-neoris-innovation-day-espa%C3%B1a).
   - Observación: El link es accesible, visible y el foco se mantiene tras la navegación. El contenido de la página de detalle es claro y estructurado.
4. Se regresa a la página de eventos usando el navegador.
5. Se hace clic en el botón "Be our guest. RSVP today" del primer evento destacado.
   - Resultado: Se accede correctamente a la página de registro del evento (https://epamneoris.com/-/cenas-ceo).
   - Observación: El botón es accesible, visible y el formulario de registro es navegable por teclado. Los campos tienen etiquetas descriptivas y foco visible.

## 5. Análisis de accesibilidad (WCAG 2.1)
- Los links y botones principales son accesibles por teclado y tienen foco visible.
- Los textos de los links son descriptivos.
- El contraste de los textos principales es adecuado.
- Falta: Validar etiquetas ARIA y roles en formularios de registro.

## 6. Issues encontrados
- No se detectan issues críticos en la navegación inicial.
- Se recomienda revisar accesibilidad de formularios de registro en próximas iteraciones.

## 7. Ejecución del flujo funcional principal
1. Ingreso a la página de eventos.
2. Acceso al detalle de un evento.
3. Acceso a la página de registro de un evento.

## 8. Test case documentado
**Caso:** Navegación y validación de accesibilidad en la página de eventos de https://epamneoris.com/events

**Pasos:**
1. Ingresar a https://epamneoris.com/events
2. Hacer clic en el link "Read more" del primer evento
   - Esperado: Se accede al detalle del evento
3. Volver a la página de eventos
4. Hacer clic en el botón "Be our guest. RSVP today" del primer evento
   - Esperado: Se accede a la página de registro
5. Validar foco, contraste y descripciones de links y botones

**Resultado esperado:**
Todos los elementos interactivos son accesibles por teclado, los links tienen descripciones claras y el flujo de registro es navegable.

---

*Este archivo será actualizado con evidencias y hallazgos adicionales tras la exploración automatizada.*
