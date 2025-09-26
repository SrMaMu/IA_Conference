# Exploración y Accesibilidad: https://www.neoris.com/

## 1. Estructura principal de la URL
- Home principal con banner superior, menú de navegación, sección de servicios, historias de éxito, formulario de contacto y pie de página.
- Banner de cookies al ingresar.
- Menú principal: Careers, Community, About, Media, Industries, Solutions.
- Secciones destacadas: "Our Services", "Success Stories", formulario de contacto.

## 2. Links principales
- Careers: https://careers.neoris.com/
- Community: /events
- About: /about
- Media: /media
- Industries: /industries
- Solutions: /solutions
- Contact: /contact
- Success Stories: https://epamneoris.com/en/success-stories
- Social: LinkedIn, Facebook, Twitter, Instagram, YouTube

## 3. Funcionalidad principal (aparente)
- Presentación de servicios de transformación digital y casos de éxito.
- Acceso a información corporativa, soluciones, industrias y contacto.
- Formulario de contacto para leads.

## 4. Paso a paso de tareas realizadas
1. Navegación inicial a https://www.neoris.com/ (redirige a https://epamneoris.com/).
2. Se visualiza banner de cookies y menú principal.
3. Se hace clic en el botón "OK" del banner de cookies.
	- Resultado: El banner desaparece correctamente y permite la navegación.
	- Observación: El botón es accesible y visible al cargar la página.
4. Se exploran los links principales del menú.
5. Se hace clic en el link "Careers" del menú principal.
	- Resultado: Se abre la página de empleos de NEORIS (https://job-boards.eu.greenhouse.io/neoris) en la misma pestaña.
	- Observación: El link es accesible, visible y redirige correctamente fuera del dominio principal.
5. Se accede a la sección "Our Services" y se listan los servicios ofrecidos.
6. Se revisa la sección "Success Stories" y se accede a un caso de éxito.
7. Se accede al formulario de contacto y se valida su presencia.

## 5. Análisis de accesibilidad (WCAG 2.1)
- El banner de cookies es accesible por teclado y tiene foco inicial.
- El menú principal es navegable por tabulación.
- Los links tienen descripciones claras.
- Se detectan contrastes adecuados en textos principales.
- Falta: Validar etiquetas ARIA y roles en formularios y banners.

## 6. Issues encontrados
- No se detectan issues críticos en la navegación inicial.
- Se recomienda revisar accesibilidad de formularios y roles ARIA en próximas iteraciones.

## 7. Ejecución del flujo funcional principal
1. Ingreso a la home y aceptación de cookies.
2. Navegación por menú principal.
3. Acceso a sección de servicios y casos de éxito.
4. Acceso y validación de formulario de contacto.

## 8. Test case documentado
**Caso:** Navegación y validación de accesibilidad en home y menú principal de https://www.neoris.com/

**Pasos:**
1. Ingresar a https://www.neoris.com/
2. Aceptar cookies haciendo clic en el botón "OK" del banner
	- Esperado: El banner desaparece y permite continuar
3. Navegar por menú principal usando teclado
4. Hacer clic en el link "Careers" del menú principal
	- Esperado: Se abre la página de empleos de NEORIS en la misma pestaña
	- Observación: El link es accesible y redirige correctamente
5. Acceder a sección "Our Services"
5. Acceder a sección "Success Stories"
6. Acceder a formulario de contacto
7. Validar foco, contraste y descripciones de links

**Resultado esperado:**
Todos los elementos son accesibles por teclado, los links tienen descripciones claras y el formulario es navegable.

---

*Este archivo será actualizado con evidencias y hallazgos adicionales tras la exploración automatizada.*
