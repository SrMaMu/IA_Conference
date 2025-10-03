# 🎯 DESIGN SYSTEM BBVA - LÍMITES UNIFICADOS
## Análisis extraído de Figma - 2025-10-03T20:15:00Z

### 🎨 PALETA DE COLORES PRINCIPAL

#### Colores Core BBVA
- **Core Blue:** `#043263` - Color principal de background
- **White:** `#FFFFFF` - Texto y elementos de contraste
- **Primary Text:** `#000000` - Texto principal en fondos claros

#### Estados y Variaciones
- **Background Principal:** `#043263` (Core Blue)
- **Texto sobre Core Blue:** `#FFFFFF` (White)
- **Contraste Principal:** Ratio AAA compliant

### 📝 SISTEMA TIPOGRÁFICO

#### Familia Principal: Benton Sans BBVA
- **Medium (500):** Títulos y elementos destacados
  - Tamaño: `24px`
  - Line Height: `32px`
  - Uso: Headers, títulos de sección
  
- **Book (400):** Texto cuerpo y descripción
  - Tamaño: `15px` 
  - Line Height: `24px`
  - Uso: Descripción, contenido informativo

#### Jerarquía Tipográfica
```css
/* Título Principal */
.title-primary {
  font-family: 'Benton Sans BBVA Medium', sans-serif;
  font-size: 24px;
  line-height: 32px;
  color: #FFFFFF;
}

/* Texto Descriptivo */
.text-body {
  font-family: 'Benton Sans BBVA Book', sans-serif;
  font-size: 15px;
  line-height: 24px;
  color: #FFFFFF;
}
```

### 📐 SISTEMA de ESPACIADO

#### Espaciado Estructural
- **Gap Principal:** `32px` - Entre secciones importantes
- **Gap Secundario:** `16px` - Padding interno de contenedores
- **Gap Mínimo:** `8px` - Elementos relacionados

#### Layout Container
- **Width Mobile:** `320px` - Ancho base mobile
- **Height Mobile:** `568px` - Alto base mobile
- **Padding Horizontal:** `16px` - Margen lateral estándar
- **Padding Vertical:** `32px` (top), `16px` (bottom)

### 🔧 COMPONENTES BASE

#### Container Principal
```css
.bbva-container {
  width: 320px;
  height: 568px;
  background-color: #043263;
  display: flex;
  flex-direction: column;
  position: relative;
}
```

#### Content Area
```css
.bbva-content {
  padding: 32px 16px 16px 16px;
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100%;
}
```

#### Header Section
```css
.bbva-header {
  display: flex;
  flex-direction: column;
  gap: 32px;
  align-items: center;
  text-align: center;
  color: #FFFFFF;
  width: 100%;
}
```

### 🎪 PATRONES DE DISEÑO

#### Patrón Card Informativa
- Background: Core Blue (#043263)
- Contenido centrado verticalmente
- Texto blanco sobre fondo azul
- Jerarquía clara: Número → Título → Descripción

#### Patrón Layout Responsive
- Mobile-first approach (320px base)
- Flexbox para estructura vertical
- Espaciado consistente y escalable
- Elementos centrados horizontalmente

### ✅ GUÍAS DE USO

#### Accesibilidad
- Contraste mínimo AA: ✅ Cumple
- Contraste mínimo AAA: ✅ Cumple  
- Tamaños de fuente legibles: ✅ 15px+ mínimo
- Espaciado táctil adecuado: ✅ 8px+ mínimo

#### Responsive Considerations
- Base mobile: 320px width
- Escalabilidad: Usar relative units cuando sea posible
- Breakpoints sugeridos: 320px, 768px, 1024px
- Mantener proporciones en diferentes tamaños

#### Implementación
```jsx
// Componente base reutilizable
const BBVACard = ({ number, title, description }) => (
  <div className="bbva-container">
    <div className="bbva-content">
      <div className="bbva-header">
        <p className="title-primary">{number}</p>
        <p className="title-primary">{title}</p>
        <p className="text-body">{description}</p>
      </div>
    </div>
  </div>
);
```

---
**Fuente:** Análisis directo de diseños Figma BBVA Límites Unificados  
**Fecha:** 2025-10-03T20:15:00Z  
**Node IDs analizados:** 384:6700, 384:7413, 384:8125, 384:8838