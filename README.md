<div align="center">

# 🏠 PropAI — AI-Powered Real Estate Discovery

**Search for properties the way you'd describe them to a friend — not the way a filter form makes you.**

[![Flutter](https://img.shields.io/badge/Flutter-Clean%20Architecture-02569B?logo=flutter)](#)
[![Node.js](https://img.shields.io/badge/Node.js-Express-339933?logo=node.js)](#)
[![MongoDB](https://img.shields.io/badge/MongoDB-Atlas-47A248?logo=mongodb)](#)
[![AI](https://img.shields.io/badge/AI-LLM%20%7C%20Embeddings%20%7C%20RAG-9E77ED)](#)
[![Status](https://img.shields.io/badge/Status-In%20Development-yellow)](#)

</div>

---

## 📌 Overview

**PropAI** is a real estate discovery platform that replaces rigid filter-based search with natural language understanding. Instead of manually setting price sliders and dropdowns, users describe what they want — *"a quiet 2-bedroom apartment near good schools, under 2 million"* — and PropAI interprets it, finds meaning-based matches using embeddings, and lets users ask a grounded AI assistant follow-up questions about any property, answered from real data instead of generic AI guesses.

This is a portfolio project built to demonstrate **applied AI engineering** — structured-output validation, hybrid filter + vector search, and grounded RAG — layered on top of a properly architected full-stack app, not a UI wrapper around a single API call.

---

## ✨ Key Features

| Feature | What it does |
|---|---|
| 🔍 **AI Natural Language Search** | Converts free-text queries into validated, structured filters via an LLM — with a strict schema-validation layer so no unchecked AI output ever reaches the database |
| 🧠 **Semantic Search** | Embeds property descriptions and user queries, then performs vector similarity search combined with structured filters for meaning-based matching |
| 💬 **RAG-Grounded AI Assistant** | Answers real estate questions (investment value, neighborhood info) using retrieval over real property + knowledge-base data — with an explicit fallback instead of hallucinating |
| 🏘️ **Property Management** | Full CRUD, advanced filtering, sorting, and pagination |
| 🗺️ **Map Discovery** *(extension)* | Geospatial "nearby" search and map-based browsing |
| 🔔 **Push Notifications** *(extension)* | Alerts for new matches to a user's saved search criteria |

> **Deliberately out of scope for v1:** agent dashboard/CRM tooling, real-time chat, admin panel, and a full recommendation engine. These are documented below as intentional Future Work — a scoping decision, not a gap.

---

## 🧱 Tech Stack

| Layer | Technology |
|---|---|
| **Frontend** | Flutter (Clean Architecture, Bloc/Cubit, Dio, Dependency Injection) |
| **Backend** | Node.js, Express.js, JWT Auth, RBAC |
| **Database** | MongoDB (Atlas) — geospatial (`2dsphere`) and vector indexes |
| **AI Layer** | LLM API (structured/JSON-schema output), Embeddings, Vector Search, RAG pipeline |
| **Extensions** | Google Maps / Mapbox, Firebase Cloud Messaging |
| **Deployment** | Render/Railway (backend), MongoDB Atlas, Flutter Web build |

---

## 🏗️ Architecture

```
Flutter Client  →  Express.js REST API  →  MongoDB
                          ↓
                    AI Service Layer
        ┌────────────┬────────────┬────────────┐
        │    LLM     │ Embeddings │    RAG     │
        │ + Schema   │ + Vector   │ Retriever  │
        │ Validation │  Search    │ + Grounded │
        │            │            │  Answering │
        └────────────┴────────────┴────────────┘
```

- **AI Search pipeline:** `User query → LLM parsing → Schema validation → MongoDB query → Ranked results`
- **Semantic Search pipeline:** `Query → Embedding → Vector search (pre-filtered) → Ranked-by-similarity results`
- **RAG pipeline:** `Question → Retriever (property + knowledge chunks) → Context assembly → LLM (constrained to context) → Grounded answer`

Full technical specification: see [`/docs/SRS.md`](./docs/SRS.md).

---

## 📂 Project Structure

```
lib/                      # Flutter app (Clean Architecture)
  core/
  features/
    auth/  property/  search/  ai_search/
    semantic_search/  ai_assistant/  map/  notifications/

server/                   # Express.js backend
  src/
    config/  middleware/  modules/  services/  utils/  routes/
```

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.x+)
- Node.js (18+)
- MongoDB Atlas account (for vector + geospatial indexes)
- LLM API key (e.g., OpenAI/Anthropic)

### Backend Setup
```bash
cd server
npm install
cp .env.example .env      # add your MongoDB URI, JWT secret, LLM API key
npm run dev
```

### Frontend Setup
```bash
cd flutter_app
flutter pub get
flutter run
```

### Environment Variables
```env
MONGODB_URI=
JWT_SECRET=
JWT_REFRESH_SECRET=
LLM_API_KEY=
EMBEDDING_MODEL=
MAPS_API_KEY=
FCM_SERVER_KEY=
```

---

## 🧪 Testing

| Layer | Coverage |
|---|---|
| Backend | Unit tests for validation service, integration tests for CRUD & search endpoints |
| AI | Prompt regression tests (fixed input → expected structured output), retrieval relevance checks |
| Flutter | Widget tests for core screens (Auth, AI Search, Assistant Chat) |

```bash
# Backend
cd server && npm test

# Flutter
cd flutter_app && flutter test
```

---

## 🗺️ Roadmap / Future Work

These are intentionally deferred beyond the current build to keep scope focused and deep rather than wide:

- [ ] Agent dashboard (listings management, lead tracking, analytics)
- [ ] AI listing description generator for agents
- [ ] Real-time chat between users and agents
- [ ] Admin panel (moderation, platform analytics)
- [ ] Personalized recommendation engine (behavior-based ranking)
- [ ] Property comparison view

---

## 📸 Screenshots / Demo

> _Add a short demo GIF or video here showing a natural-language query producing results, and the AI assistant answering a grounded question._

| AI Search | Semantic Match | AI Assistant |
|---|---|---|
| _screenshot_ | _screenshot_ | _screenshot_ |

---

## 📄 Documentation

- [Software Requirements Specification (SRS)](./docs/SRS.md)
- [UI/UX Screen Specifications](./docs/UI_SCREENS.md)
- [Component & Style Guide](./docs/STYLE_GUIDE.md)
- [API Reference](./docs/API.md)

---

## 🎯 Why This Project

PropAI was built to demonstrate the full lifecycle of a real product — not just a mobile UI exercise. It required designing a multi-service backend, structuring MongoDB schemas and indexes around real query patterns, integrating and *validating* multiple AI/service APIs rather than trusting them blindly, optimizing geospatial and vector queries, and shipping a deployed, testable system end-to-end.

The three core technical decisions worth highlighting:
1. **Structured-output validation** — no LLM output reaches the database unchecked.
2. **Hybrid filter + vector search** — semantic relevance without sacrificing precise constraints.
3. **Grounded RAG** — the assistant declines to answer rather than hallucinate when retrieval is weak.

---

## 📝 License

This project is available under the MIT License.

---

<div align="center">
Built by <strong>Dany Ashraf</strong> — a portfolio project demonstrating full-stack + applied AI engineering.
</div>
