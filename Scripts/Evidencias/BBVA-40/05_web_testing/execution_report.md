# 🏦 BBVA-40 - Evidencia Web Testing

## Estado de Ejecución
- Fecha: 2025-10-03
- Entorno: https://desa1-qa.bbva.com.ar/fnetcore/login/index.html
- Usuario utilizado: miusuario (sin CS)

## Pasos realizados
1. Login web con credenciales reales:
   - Tipo de documento: DNI
   - Número de documento: 10240480
   - Usuario: miusuario
   - Clave: micd1122
2. Selectores críticos del login capturados y guardados en `automatizaciones/web_selectors.json`.
3. El sistema muestra "Cargando..." tras el login, indicando avance correcto.

## Estado actual
- El script y la automatización web quedan **incompletos**.
- No se pudo avanzar a pantallas de tarjetas/productos por limitaciones de acceso o flujo.
- Listo para continuar cuando se habilite el acceso o se resuelvan bloqueos.

## Observaciones
- El usuario CSmiusuario es solo para mobile, no para web.
- Todos los selectores utilizados están documentados para futuras automatizaciones.
- Se recomienda reintentar el flujo cuando el acceso esté disponible.
