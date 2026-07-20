# Enclosed Constitutional DevSecOps AI Stack 🛡️

A production-ready reference architecture for an enclosed, air-gapped multi-agent AI ecosystem. This project demonstrates how specialized software development lifecycle (SDLC) agents can be strictly bound to a local, immutable policy framework—the **Court of Arbitration**—ensuring determinism, auditability, and data privacy without relying on unrestricted third-party cloud APIs.

## 🎯 The Core Philosophy

The engineering community often struggles with the fear of autonomous AI agents executing unconstrained code or drifting from design intentions. This stack demonstrates an environment where:

1. **Multi-agents are specialized** into tight, single-responsibility domains such as coding, SAST, SCA, and DAST.
2. **All workflows flow through an Arbiter Agent** acting as an unyielding judicial system.
3. **The Court of Arbitration Manifest** is mounted as an immutable, read-only volume.
4. **Humans retain final authority** for consequential decisions, exceptions, modification, and deployment.
5. **Evidence, provenance, disagreement, and uncertainty remain visible** rather than being replaced by persuasive AI language.

The goal is high operational velocity without surrendering safety, accountability, or alignment with human-defined constitutional standards.

## 📜 Governance map

The repository separates constitutional authority, reusable doctrine, architecture decisions, machine-readable policy, implementation, and evidence.

- [Constitution](docs/CONSTITUTION.md) — highest governing engineering charter
- [Architecture Decision Records](docs/ADR/README.md) — permanent record of material architectural decisions
- [ADR-0001: Canonical Finding Contract](docs/ADR/ADR-0001-Canonical-Finding-Contract.md)
- [ADR-0002: Human-Centered Collaborative Platform Doctrine](docs/ADR/ADR-0002-Human-Centered-Platform-Doctrine.md) — proposed
- [Human-Centered Collaborative Platform Doctrine](docs/doctrine/HUMAN-CENTERED-PLATFORM-DOCTRINE.md) — proposed reusable governance for distributed Human–AI platforms
- [Machine-readable Constitution](config/constitution.yaml)
- [Canonical finding schema](schemas/finding.schema.json)

The Human-Centered Collaborative Platform Doctrine governs reusable principles such as durable data authority, elected operational leadership, offline synchronization, truthful trusted-companion interfaces, language governance, outsourced payment-card boundaries, plugin entitlements, and least-privilege cross-platform packaging.

Product repositories retain their own implementation ADRs, threat models, code, tests, and private data. This governance repository must not become a store for product secrets or client information.

---

## 📊 What-If Structural Efficiency Analysis

| Metric / Dimension | 1. Standalone Human | 2. Human + AI Collaborative | 3. Control Board Supervised AI | 4. Constitutional Autonomous AI |
| :--- | :--- | :--- | :--- | :--- |
| **Throughput & Velocity** | **Very Low** (Hours/days per cycle) | **Medium** (Human remains the processing bottleneck) | **High** (Minutes; automated runtimes with manual gates) | **Extreme** (Seconds; continuous loop integration) |
| **Error Rate & Drift** | **Variable** (Fatigue-driven, inconsistent policy checks) | **Low** (AI assists tracking, human manually verifies) | **Minimal** (AI blocks errors, human handles edge cases) | **Deterministic** (Strict schema and policy adherence within validated coverage) |
| **Compute / Resource Cost** | **High Cost** (Salaries, context-switching overhead) | **Balanced** (SaaS licenses + engineering hours) | **Optimized** (Localized compute + targeted review windows) | **Highly Cost-Efficient** (Compute-focused, predictable system bounds) |
| **Primary Failure Vector** | **Siloing** (Knowledge loss, missed checklists) | **Alert Fatigue** (Human rubber-stamping AI outputs) | **Deadlocks** (Human delay approving complex edge cases) | **Edge Misalignment** (Code patterns outside rule constraints) |

---

## 🏗️ Architecture Layout

```text
devsecops-stack/
├── .gitignore
├── LICENSE
├── README.md
├── docker-compose.yml
├── config/
│   └── constitution.yaml
├── docs/
│   ├── CONSTITUTION.md
│   ├── ADR/
│   └── doctrine/
├── schemas/
│   └── finding.schema.json
├── manifest/
│   └── security-policy.json
└── orchestrator/
    ├── Dockerfile
    ├── main.py
    └── schemas.py
```

---

## ⚡ Quickstart

### Prerequisites

- Windows 10/11 with **WSL2** installed
- **Docker Desktop** configured for Linux containers
- 8-core CPU and 16 GB+ RAM recommended for local model workloads

### Installation and deployment

```bash
git clone https://github.com/dbrewerton/constitutional-ai-devsecops-mesh.git
cd constitutional-ai-devsecops-mesh
docker compose up --build -d
```

Watch the orchestrator:

```bash
docker logs -f agent-orchestrator-core
```

### Running a validation scan

Simulate an untrusted sub-agent attempting to introduce a prohibited dependency license:

```bash
curl -X POST "http://localhost:8000/arbitrate" \
     -H "Content-Type: application/json" \
     -d '{"artifact_name":"package.json","content":"{\"dependencies\":{\"banned-copyleft\":\"GPL-3.0\"}}"}'
```

## The Traceability Ledger

The orchestrator preserves who, what, where, when, why, evidence, applied policy, and decision state. Scanner or AI output is not automatically accepted as verified evidence.

Illustrative result:

```json
{
  "verdict": "REJECTED",
  "evaluation_context": {
    "target_artifact": "package.json"
  },
  "decision_rationale": {
    "who": "Supply-Chain Inspector",
    "what": "Detected a prohibited dependency license",
    "where": "Dependency manifest",
    "why": "The proposed artifact conflicts with the active license policy"
  },
  "human_review_required": true
}
```

## Change governance

Constitutional and doctrinal changes must be explicit, version-controlled, reviewed for security and operational impact, and approved by authorized humans. Proposed ADRs and doctrines are not accepted merely because an agent created a branch or pull request.
