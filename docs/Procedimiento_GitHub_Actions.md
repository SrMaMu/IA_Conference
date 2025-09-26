# Documentación del Procedimiento - GitHub Actions Workflow

## Resumen del Proceso Ejecutado
Fecha: 26 de Septiembre de 2025

### Problema Identificado
- El workflow no aparecía en GitHub Actions del repositorio IA_Conference
- Se estaba trabajando erróneamente en el repositorio automatizaciones-scripts
- Falta de trigger `push` en el workflow

### Solución Implementada

#### 1. Configuración del Repositorio Correcto
```bash
cd IA_Conference
git remote set-url origin https://github.com/SrMaMu/IA_Conference.git
```

#### 2. Estructura Creada
- `docs/` - Documentación
- `infra/` - Infraestructura  
- `automatizaciones/` - Scripts automatizados
- `.github/workflows/` - Workflows de GitHub Actions

#### 3. Workflow Configurado
**Ubicación**: `.github/workflows/robotframework.yml`

**Contenido**:
```yaml
name: Automatizaciones Robot Framework

on:
  push:
    branches: [ main ]
  schedule:
    - cron: '0 3 * * *' # Ejecuta todos los días a las 03:00 UTC
  workflow_dispatch:

jobs:
  robot:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repo
        uses: actions/checkout@v4
      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.x'
      - name: Install Robot Framework
        run: |
          pip install robotframework selenium robotframework-seleniumlibrary
      - name: Run Robot tests
        run: |
          robot automatizaciones/
```

#### 4. Scripts Migrados
- `IAC-8.robot` movido de Scripts/Funcionales/ a automatizaciones/

#### 5. Comandos Ejecutados
```bash
# Agregar trigger push al workflow
git add .github/workflows/robotframework.yml
git commit -m "Agregar trigger push al workflow para activación inmediata"
git push origin main
```

### Resultado Final
- ✅ Repositorio IA_Conference correctamente configurado
- ✅ Workflow visible y ejecutable en GitHub Actions
- ✅ Scripts automatizados en la carpeta correcta
- ✅ Triggers configurados: push, schedule, manual
- ✅ Dependencias de Robot Framework configuradas

### Lecciones Aprendidas
1. **Repositorio correcto**: Siempre verificar que se trabaja en IA_Conference
2. **Trigger push obligatorio**: Sin este trigger, el workflow no se activa inmediatamente
3. **Estructura de carpetas**: Debe estar en la raíz del repositorio, no en subcarpetas
4. **Remoto correcto**: Configurar el remoto hacia IA_Conference, no automatizaciones-scripts

### Validación
- El workflow aparece en https://github.com/SrMaMu/IA_Conference/actions
- Se ejecuta automáticamente en cada push a main
- Programado para ejecución diaria a las 03:00 UTC
- Disponible para ejecución manual