# BlindSpot AI — Intelligent Assumption, Constraint & Risk Discovery Platform

[![FastAPI](https://img.shields.io/badge/Backend-FastAPI-009688.svg?style=flat&logo=fastapi)](https://fastapi.tiangolo.com)
[![React](https://img.shields.io/badge/Frontend-React%20%2B%20Vite-61DAFB.svg?style=flat&logo=react)](https://react.dev)
[![Tailwind CSS](https://img.shields.io/badge/Styling-Tailwind%20CSS-38B2AC.svg?style=flat&logo=tailwind-css)](https://tailwindcss.com)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

**BlindSpot AI** is a modern, production-style full-stack platform designed to systematically analyze project specifications, datasets, and architecture workflows to uncover hidden failure points before kickoff.

---

## 1. Problem Statement

Most large-scale engineering and enterprise projects fail not because of known problems, but because of **unidentified blind spots**:
- **Unverified Assumptions:** Believing third-party services guarantee 100% uptime, low latency, or that historical datasets generalize without bias.
- **Overlooked Constraints:** Missing critical compliance frameworks (HIPAA, FCRA, GDPR, SOC2), API rate limits, or disaster recovery objectives (RTO/RPO).
- **Single Points of Failure (SPOF):** Hidden bottlenecks in database tiers or lack of graceful degradation.
- **Data Quality Ingestion Issues:** High missingness rates in predictive features, duplicate primary identifiers, or biological/financial range violations.
- **Incomplete Requirements:** Undefined error handling, lack of adverse action explanations, and absence of role-based access control (RBAC).

---

## 2. Key Capabilities & Workflow

1. **Multi-Format Ingestion:**
   - **Documents:** PDF (PyMuPDF) and Word DOCX (python-docx) specifications, PRDs, and architecture blueprints.
   - **Datasets:** CSV and Excel files (pandas/openpyxl) with automated statistical profiling.
   - **Workflows:** Multi-step pipeline text and markdown.
2. **Automated Dataset Profiler:** Computes row/column dimensions, missingness percentages, duplicate identifiers, domain range violations, and statistical IQR outliers.
3. **Dual Discovery Engine (AI + Deterministic Demo Mode):**
   - Configurable LLM API integration (OpenAI / Gemini compatible).
   - Fully functional, deterministic rule-based analysis engine if an API key is unavailable. Runs complete checks without pretending to be an AI.
4. **Transparent Prioritization System:** Every discovery receives a mathematically computed Priority Score with transparent formula breakdown.
5. **Interactive Report & Status Tracking:** Mark discoveries as `Open`, `Accepted`, `Resolved`, or `Dismissed` with persistent mitigation notes.
6. **Multi-Format Export:** Instant export to downloadable CSV and executive PDF reports (ReportLab).

---

## 3. Transparent Prioritization System

BlindSpot AI replaces opaque rankings with a clear mathematical score:

$$\text{Priority Score} = \text{Impact} \times \left(\frac{\text{Confidence}}{100}\right) \times \left(\frac{\text{Urgency}}{5}\right) \times 10$$

- **Impact Score (1–10):** Potential consequence if the blind spot manifests.
- **Confidence Level (0–100%):** Strength of evidence found in supplied material.
- **Urgency (1–5):** How soon the risk requires team investigation.
- **Priority Tiers:**
  - **Critical:** 75.0 – 100.0
  - **High:** 50.0 – 74.9
  - **Medium:** 25.0 – 49.9
  - **Low:** below 25.0

---

## 4. Technology Stack

- **Frontend:** React 18, Vite, Tailwind CSS, Recharts, Lucide Icons.
- **Backend:** Python 3.14 / 3.11+, FastAPI, Uvicorn, Pydantic v2, SQLAlchemy.
- **Database:** SQLite with SQLAlchemy ORM.
- **Document & Data Parsers:** PyMuPDF (`pymupdf`), `python-docx`, `pandas`, `openpyxl`.
- **Report Generation:** `reportlab` (PDF generation), standard `csv` module.
- **Testing:** `pytest`, `pytest-asyncio`, FastAPI `TestClient`.

---

## 5. Quick Start Instructions

### Prerequisites
- Python 3.10+ (tested through 3.14)
- Node.js 18+ and npm

### Backend Setup

```bash
cd backend

# Create and activate virtual environment
python3 -m venv venv
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# (Optional) Configure AI API Key
# Copy .env.example to .env and set OPENAI_API_KEY or GEMINI_API_KEY
# If left blank, BlindSpot AI runs in fully functional Rule-Based Demo Mode
cp .env.example .env

# Seed initial demonstration analyses (Optional)
python app/seed.py

# Start FastAPI server (runs at http://localhost:8000)
uvicorn app.main:app --reload --port 8000
```

### Frontend Setup

```bash
cd frontend

# Install npm dependencies
npm install

# Start Vite development server (runs at http://localhost:5173)
npm run dev
```

Open your browser at **`http://localhost:5173`**.

---

## 6. Running Tests

Run the comprehensive unit and integration test suite:

```bash
cd blindspot-ai
PYTHONPATH=backend ./venv/bin/pytest backend/tests -v
```

The test suite validates:
- API endpoints (`/api/health`, `/api/analyses`, `/api/analyses/{id}`, export endpoints)
- Dataset profiling logic (outliers, null rates, duplicate primary keys)
- Transparent priority score calculations and clamping bounds
- Status and notes updates

---

## 7. REST API Reference

| Method | Endpoint | Description |
|---|---|---|
| `GET` | `/api/health` | Health status and AI provider configuration info |
| `GET` | `/api/analyses/dashboard/stats` | Aggregated dashboard telemetry and Recharts stats |
| `GET` | `/api/analyses` | List all historical analyses |
| `POST` | `/api/analyses` | Create analysis (Multipart form with file upload or text) |
| `POST` | `/api/analyses/json` | Create analysis via JSON payload |
| `GET` | `/api/analyses/{id}` | Retrieve analysis details with findings & dataset profile |
| `POST` | `/api/analyses/{id}/run` | Execute or re-run discovery engine |
| `GET` | `/api/analyses/{id}/findings` | Retrieve findings with category/severity/status filters |
| `PATCH` | `/api/findings/{id}` | Update finding status (`open`, `accepted`, `resolved`, `dismissed`) or notes |
| `GET` | `/api/analyses/{id}/export?format=csv` | Export findings as CSV |
| `GET` | `/api/analyses/{id}/export?format=pdf` | Download executive PDF report |
| `DELETE` | `/api/analyses/{id}` | Delete analysis and cascading records |

---

## 8. Pre-Built Demonstration Templates

To evaluate the application with zero manual setup, click any of the 1-click templates inside the **New Analysis** page:
1. **CarePulse AI — Clinical Patient Triage Engine (Healthcare):** Uncovers unaddressed HIPAA BAA omissions, clinician-in-the-loop bypass, and WiFi latency assumptions.
2. **ApexFlow — Consumer Underwriting Dataset Quality (FinTech):** Automatically profiles missing credit scores (32%), customer ID collisions, and negative age ranges.
3. **Project Titan — Core Banking Cloud Migration (Enterprise Architecture):** Identifies single master Oracle RDS bottleneck, missing webhook circuit breakers, and unthrottled burst risks.
