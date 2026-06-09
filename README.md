# 🏦 InicioBBVA — App iOS para MiPyMES

App móvil en SwiftUI desarrollada durante el **Hackathon BBVA Guadalajara 2025**. Ayuda a micro, pequeñas y medianas empresas a formalizarse, conocer sus opciones financieras y acceder a productos BBVA adaptados a su tamaño y giro.

---

## 📱 Pantallas

| Pantalla | Descripción |
|---|---|
| **Bienvenida** | Pantalla de inicio con CTA para comenzar el registro |
| **Requerimientos** | Lista de documentos necesarios para abrir cuenta empresarial |
| **¿Cómo operas?** | Selección de tipo de negocio: persona física o empresa con socios |
| **Datos personales** | Formulario con nombre, email, teléfono, CURP y foto de identificación |
| **Registro SAT** | Verifica si el usuario está registrado ante el SAT con tutorial de apoyo |
| **Datos del negocio** | Nombre, giro, ubicación y método de cobro actual |
| **Dashboard bancario** | Balance, acciones rápidas y historial de transacciones |
| **Mis tarjetas** | Carrusel de tarjetas con ajustes de pagos, ATM y contactless |
| **Mapa de zonas** | Mapa de Monterrey con niveles de oportunidad para negocios (MapKit) |
| **Código QR** | QR del negocio con datos de contacto y horarios |
| **Chatbot** | Asistente financiero para MiPyMES con respuestas sin conexión |

---

## 🗺 Flujo de onboarding

```
Bienvenida (Register)
  └─→ Requerimientos
        └─→ ¿Cómo operas? (ComoOpera)
              └─→ Datos personales (SimpleFormView)
                    └─→ Registro SAT (SatRegistroView)
                          └─→ Datos del negocio (NegocioFormView)
```

---

## 🗂 Estructura del proyecto

```
InicioBBVA/
├── InicioBBVAApp.swift        → Entry point (@main)
├── Register.swift             → Pantalla de bienvenida y navegación principal
├── Requerimientos.swift       → Documentos necesarios
├── ComoOpera.swift            → Tipo de negocio
├── DatosPersoForm.swift       → Formulario de datos personales
├── RegistroSAT.swift          → Estado ante el SAT
├── Negocio.swift              → Datos del negocio
├── Inicio.swift               → Dashboard bancario
├── ContentView.swift          → Vista de tarjetas bancarias
├── MapaPapelerias.swift       → Mapa de oportunidades (MapKit)
├── BusinessQRView.swift       → Código QR del negocio
├── CameraView.swift           → Captura de documentos con cámara
├── ChatbotView.swift          → Interfaz del chatbot
├── ChatbotManager.swift       → Lógica del chatbot
├── ChatbotData.swift          → Modelos de datos del chatbot
├── datoschatbot.json          → Base de conocimientos del chatbot
└── Model/
    ├── Permission.swift       → Manejo de permisos
    └── QRScannerDelegate.swift → Delegado del escáner QR
```

---

## 🤖 Chatbot financiero

El asistente responde **sin necesidad de conexión a internet** — toda la base de conocimientos vive en `datoschatbot.json`. Puede ayudar con:

- Consejos de inversión para el negocio
- Tips de finanzas y flujo de efectivo
- Estrategias de crecimiento
- Información sobre equipamiento con crédito BBVA
- **Clasificación del tamaño de empresa** según empleados e ingresos anuales:

| Tipo | Empleados | Ingresos anuales |
|---|---|---|
| Microempresa | Hasta 10 | Hasta $5 MDP |
| Pequeña Empresa | Hasta 50 | Hasta $60 MDP |
| Mediana Empresa | Hasta 250 | Hasta $140 MDP |

---

## ⚙️ Requisitos

- Xcode 15 o superior
- iOS 17+
- No requiere API keys externas — funciona completamente offline

---

## 📦 Frameworks utilizados

- `SwiftUI` — Interfaz de usuario
- `MapKit` — Mapa de zonas de oportunidad
- `PhotosUI` — Selector de foto de identificación
- `AVKit` — Cámara para documentos
- `UIKit` — Componentes nativos

---

## 🏆 Contexto

Proyecto desarrollado en equipo durante el **Hackathon BBVA Guadalajara 2025**, con el objetivo de facilitar la formalización y el acceso a servicios financieros para micro y pequeños empresarios en México.

---

## 👩‍💻 Autores

Desarrollado por **Damaris B** y **Asenet** · Mayo 2025
