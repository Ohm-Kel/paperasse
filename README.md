# Paperasse

Bilingual LangGraph agent that plans French administrative procedures for international students, with cited official sources and human approval.

[![CI](https://github.com/Ohm-Kel/paperasse/actions/workflows/ci.yml/badge.svg)](https://github.com/Ohm-Kel/paperasse/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
![Python 3.12](https://img.shields.io/badge/python-3.12-blue.svg)

> **Status:** scaffolding (pre-v0.1). The app serves a health check only; the features below arrive release by release.

## Demo

Coming with v0.5 (chat interface).

## Problem and solution

International students arriving in France face a chain of procedures (residence permit, health insurance, housing aid, bank account, university enrolment) whose rules are spread across French government sites, and each step depends on the one before. Paperasse works out which procedures apply to a student, orders them by their dependencies, and prepares a dated checklist, draft letters and calendar reminders, citing an official source for every rule. The student approves every output; nothing is sent for them.

## Features

Planned, by release:

- **v0.1** Ingestion of official sources into Postgres with pgvector; cited answers from the command line
- **v0.2** Hybrid search, reranking and fine-tuned embeddings, measured in an ablation table
- **v0.3** LangGraph question flow with a classifier router, clarifying questions and a groundedness check
- **v0.4** Procedure planner with five typed tools, an approval step and an MCP server
- **v0.5** Streaming API, chat interface, guardrails and Langfuse tracing
- **v1.0** Azure deployment, weekly source refresh and a user test

## Architecture

Diagram coming with v0.1.

## Tech stack

Python 3.12, uv, FastAPI, Ruff, mypy, pytest, Docker and GitHub Actions so far. LangGraph, Postgres with pgvector, Groq, Langfuse and Azure arrive with the releases above.

## Getting started

### Prerequisites

- [uv](https://docs.astral.sh/uv/getting-started/installation/) (it installs Python 3.12 if it is missing)
- Git

### Installation

```powershell
git clone https://github.com/Ohm-Kel/paperasse.git
cd paperasse
uv sync
uv run pre-commit install
```

### Environment variables

None are needed yet. Copy `.env.example` to `.env` when a release adds one.

### Running locally

```powershell
uv run uvicorn paperasse.api.app:app --reload
```

Then open http://localhost:8000/health, or http://localhost:8000/docs for the OpenAPI docs.

### Running tests

```powershell
uv run pytest --cov
uv run pre-commit run --all-files
```

## Usage examples

Coming with v0.1.

## Evaluation results

Coming with v0.1 (baseline retrieval metrics on 60 questions).

## Project structure

```text
paperasse/
├── src/paperasse/        # the package
│   └── api/              # FastAPI app
├── tests/unit/           # unit tests
├── docs/adr/             # decision records
├── .github/workflows/    # CI: checks, tests, Docker smoke test
├── Dockerfile
└── pyproject.toml        # pinned dependencies and tool settings
```

## Roadmap

See the releases under Features. After v1.0: Terraform for the Azure resources, OIDC sign-in from GitHub Actions, Key Vault, and more cities and languages.

## Contributors and roles

- Semanu Kwaku Sebuava ([@Ohm-Kel](https://github.com/Ohm-Kel)): design, engineering and evaluation

## License

[MIT](LICENSE)
