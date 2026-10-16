EHS Track Pro — Environment, Health, and Safety (EHS) Platform

Preview unavailable

📌 Executive Summary

EHS Track Pro is a comprehensive, multi-language Environment, Health, and Safety management application designed to streamline occupational safety compliance, incident reporting, and environmental tracking. It enables safety officers, auditors, and management to fill, edit, and manage all essential EHS documentation directly, annotate multimedia hazard photos, capture digital signatures, and generate professional PDF reports.

Designed with a user-centric approach, the app features a "Visual Comfort & Calmness" color palette (Deep Sage #2D6A4F and Soft Slate Blue #1D3557 over glare-free #F8F9FA) to reduce eye fatigue for field workers operating in high-stress environments.

🚀 Quick Start — Instant Running Web Application

You can launch and test the complete application immediately in your browser without installing any runtimes or compilers:

Open the file index.html located at:
text
c:\Users\elhim\Downloads\APP\index.html
Double click index.html or open with Google Chrome, Microsoft Edge, or Safari.
✨ What Works in index.html:
Live Language & Direction Switching (i18n):
Arabic (العربية): Native Right-to-Left (RTL) layout with Readex Pro & Tajawal typography.
English: Left-to-Right (LTR) layout with Inter typography.
French (Français): Full French localization and layout.
Visual Comfort & Night Shift Mode: One-click toggle between glare-free daytime mode and low-light dark mode (#121816).
Interactive Hazard Annotation Canvas: Draw directly with finger/mouse over uploaded site photos, draw hazard boundary circles, arrows, and highlight risk zones.
Electronic Digital Signature Pad: Sign authorizations and permits directly on-screen with capacitive touch or mouse.
Auto-PDF Export: One-click generation and instant download of official vector PDFs with corporate headers, metadata, and cryptographic electronic signatures.
CAPA Lifecycle Management: Add new corrective actions, filter by status (All, In Progress, Closed, Overdue), and update completion state.
Offline-First Persistence: Works with or without an internet connection using local browser storage and sync simulation.
📁 Project Architecture & Directory Structure
text
c:\Users\elhim\Downloads\APP\
├── index.html                  # Unified, interactive multilingual application (Web/PWA)
├── README.md                   # This project guide & documentation
│
├── ehs_mobile_flutter/         # Complete Flutter Cross-Platform Mobile Codebase
│   ├── pubspec.yaml            # Flutter dependencies (SQLite, PDF, Signature, RTL)
│   └── lib/
│       ├── main.dart           # App entrypoint with RTL delegates & tab shell
│       ├── core/
│       │   ├── theme/          # Visual comfort palette (#2D6A4F / #1D3557)
│       │   └── database/       # Offline SQLite helper & delta sync outbox
│
├── ehs_backend_api/            # Node.js / Express + PostgreSQL REST API
│   ├── package.json            # Express, pg, helmet, JWT, multer
│   ├── .env.example            # Environment variables template
│   └── src/
│       ├── server.js           # Server bootstrap & security middleware
│       ├── config/db.js        # PostgreSQL connection pool
│       ├── database/schema.sql # Enterprise schema (RBAC, Incidents, CAPA, Sync)
│       ├── middleware/         # JWT auth & RBAC guards (5 roles)
│       ├── controllers/        # Incident, CAPA, and Delta Sync controllers
│       └── routes/             # REST endpoints (/api/v1/...)
│
├── serene_compliance/          # Master Design System (DESIGN.md)
├── ehs_dashboard/              # Dashboard UI prototype (code.html & screen.png)
├── report_incident/            # Incident logging UI prototype (code.html & screen.png)
├── capa_management/            # CAPA management UI prototype (code.html & screen.png)
├── audit_inspection/           # Audit execution UI prototype (code.html & screen.png)
└── forms_reports/              # Smart forms & PTW UI prototype (code.html & screen.png)
📱 Mobile Architecture (Flutter)

When Flutter is installed on your development workstation:

bash
cd ehs_mobile_flutter
flutter pub get
flutter run
Supports iOS, Android, and Desktop.
Native RTL layout with Google Fonts (Readex Pro, Tajawal).
Local SQLite database with Outbox pattern for delta offline sync.
🛡️ Backend Architecture (Node.js & PostgreSQL)

When Node.js and PostgreSQL are installed:

Navigate to the backend directory:
bash
cd ehs_backend_api
npm install
Create your PostgreSQL database:
bash
psql -U postgres -c "CREATE DATABASE ehs_track_pro_db;"
psql -U postgres -d ehs_track_pro_db -f src/database/schema.sql
Copy .env.example to .env and adjust database credentials.
Run the API:
bash
npm run dev
The API will listen at http://localhost:5000/api/v1.
Core API Endpoints:
POST /api/v1/sync/delta — Synchronizes batched offline mutations from field devices.
GET  /api/v1/dashboard/kpis — Returns real-time LTIFR, TRIR, and CAPA closure metrics.
GET  /api/v1/incidents — Lists all incidents with reporter metadata.
POST /api/v1/incidents — Logs a new hazard or injury report.
GET  /api/v1/capas — Lists all CAPAs.
POST /api/v1/capas — Assigns a corrective action to a responsible team member.
PATCH /api/v1/capas/:id/close — Closes a verified corrective action.
          gradle wrapper
          ./gradlew assembleRelease --stacktrace
      - name: Upload Release APK Artifact
        uses: actions/upload-artifact@v4
        with:
          name: EHS-Track-Pro-Release-APK
