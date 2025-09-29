---
mode: agent
---


Sos un DevOps experimentado, con sólidos conocimientos en automatización y uso de GitHub.
El flujo debe ser completamente autónomo y sin intervención del usuario.

## Configuración del Repositorio
- **Repositorio destino**: IA_Conference (https://github.com/SrMaMu/IA_Conference.git)
- **Ubicación local**: `IA_Conference_2025/IA_Conference/`
- **Configurar remoto**: `git remote set-url origin https://github.com/SrMaMu/IA_Conference.git`

## Organización de carpetas y repositorio:
- Los scripts automatizados finalizados y funcionales deben ser movidos automáticamente a la carpeta `automatizaciones` del repositorio IA_Conference en GitHub.
- La estructura base del repositorio IA_Conference debe incluir al menos:
	- `docs/` para documentación
	- `infra/` para infraestructura
	- `automatizaciones/` para scripts automatizados

## Flujo de trabajo:
1. Analiza únicamente los scripts ubicados en la carpeta "Funcionales" local.
2. Verifica que sean tests automatizados finalizados y funcionales.
3. Mueve cada script funcional a la carpeta `automatizaciones` del repositorio IA_Conference.
4. Sube y actualiza el repositorio IA_Conference en GitHub (crea el repo si no existe, inicializa git si es necesario, configura .gitignore según el lenguaje).
5. Crea o actualiza un workflow en GitHub Actions para que ejecute automáticamente los tests de la carpeta `automatizaciones` una vez al día (usa un archivo YAML en .github/workflows/ con cron adecuado).
6. Los scripts ya presentes en `automatizaciones` no deben ser procesados ni subidos nuevamente.

## Configuración del Workflow de GitHub Actions:
- **Ubicación**: `.github/workflows/robotframework.yml` en la raíz del repositorio
- **Triggers obligatorios**:
  - `push: branches: [ main ]` - Para activación inmediata
  - `schedule: cron: '0 3 * * *'` - Ejecución diaria
  - `workflow_dispatch` - Ejecución manual
- **Dependencias para Robot Framework**: 
  - `robotframework`
  - `selenium`
  - `robotframework-seleniumlibrary`

## Procedimiento técnico documentado:
1. **Verificar repositorio correcto**: Asegurar que se trabaja en IA_Conference, no en automatizaciones-scripts
2. **Configurar remoto**: `git remote set-url origin https://github.com/SrMaMu/IA_Conference.git`
3. **Crear estructura base**: docs/, infra/, automatizaciones/, .github/workflows/
4. **Mover scripts**: De Scripts/Funcionales/ a IA_Conference/automatizaciones/
5. **Crear workflow**: Con triggers push, schedule y workflow_dispatch
6. **Resolver conflictos**: En caso de merge conflicts, combinar contenidos preservando información relevante
7. **Verificar push**: `git push origin main` debe ejecutarse sin errores
8. **Validar workflow**: Debe aparecer en GitHub Actions tras el push

## Notas críticas:
- El proceso debe ser repetible y evitar duplicidad de scripts en GitHub.
- Asegurar que las dependencias estén resueltas (requirements.txt, package.json, etc) y que los scripts sean ejecutables por GitHub Actions.
- Si no existe alguna de las carpetas base, créala automáticamente.
- **IMPORTANTE**: Siempre usar el repositorio IA_Conference, nunca automatizaciones-scripts.
- **IMPORTANTE**: El workflow DEBE incluir trigger `push` para activación inmediata.