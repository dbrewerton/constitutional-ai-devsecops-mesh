# Enclosed Constitutional DevSecOps AI Stack 🛡️

A production-ready reference architecture for an enclosed, air-gapped multi-agent AI ecosystem. This project demonstrates how specialized software development lifecycle (SDLC) agents can be strictly bound to a local, immutable policy framework—the **Court of Arbitration**—ensuring absolute determinism, audibility, and data privacy without relying on third-party cloud APIs.

## 🎯 The Core Philosophy
The engineering community often struggles with the "irrational fear" of autonomous AI agents executing unconstrained code or drifting from design intentions. This stack proves that by structuring an environment where:
1. **Multi-Agents are specialized** into tight, single-responsibility domains (Coding, SAST, SCA, DAST).
2. **All workflows flow through an Arbiter Agent** acting as an unyielding judicial system.
3. **The Court of Arbitration Manifest** is mounted as an immutable, read-only volume.

We achieve extreme operational velocity while guaranteeing that the environment and code remain fundamentally safe, controlled, and perfectly aligned with human-defined constitutional standards.

---

## 📊 What-If Structural Efficiency Analysis
This project maps architectural trade-offs across four operational paradigms to highlight the safety and throughput advantages of a Constitutional Autonomous setup.

| Metric / Dimension | 1. Standalone Human | 2. Human + AI Collaborative | 3. Control Board Supervised AI | 4. Constitutional Autonomous AI |
| :--- | :--- | :--- | :--- | :--- |
| **Throughput & Velocity** | **Very Low** (Hours/days per cycle) | **Medium** (Human remains the processing bottleneck) | **High** (Minutes; automated runtimes with manual gates) | **Extreme** (Seconds; continuous loop integration) |
| **Error Rate & Drift** | **Variable** (Fatigue-driven, inconsistent policy checks) | **Low** (AI assists tracking, human manually verifies) | **Minimal** (AI blocks errors, human handles edge cases) | **Deterministic** (Zero human drift, strict schema adherence) |
| **Compute / Resource Cost**| **High Cost** (Salaries, context-switching overhead) | **Balanced** (SaaS licenses + engineering hours) | **Optimized** (Localized compute + targeted review windows) | **Highly Cost-Efficient** (Compute-only; predictable system bounds) |
| **Primary Failure Vector** | **Siloing** (Knowledge loss, missed checklists) | **Alert Fatigue** (Human rubber-stamping AI outputs) | **Deadlocks** (Human delay approving complex edge-cases) | **Edge Misalignment** (Code patterns outside rule constraints) |

---

## 🏗️ Architecture Layout

```text
devsecops-stack/
├── .gitignore              # Prevents pushing massive model weights or private local workspaces
├── LICENSE                 # Apache-2.0 open-source verification
├── README.md               # Project charter, quickstart, and metrics
├── CONSTITUTION.md         # Ethical and operational bounding rules for the agents
├── docker-compose.yml      # Multi-container isolated network mesh blueprint
├── manifest/
│   └── security-policy.json # The immutable Court of Arbitration baseline rules
└── orchestrator/
    ├── Dockerfile          # Python execution sandbox configuration
    ├── main.py             # Asynchronous FastAPI routing layer
    └── schemas.py          # Strict Pydantic logging data contracts
```

---

## ⚡ Quickstart

### Prerequisites
* Windows 10/11 with **WSL2** installed.
* **Docker Desktop** configured for Linux Containers.
* 8 Core CPU & 16GB+ RAM recommended (The local stack runs highly efficient 3B parameter models completely on-device).

### Installation & Deployment
1. Clone this repository locally:
   ```bash
   git clone https://github.com
   cd devsecops-stack
   ```
2. Spin up the enclosed environment in detached mode:
   ```bash
   docker compose up --build -d
   ```
3. Watch the background orchestrator automatically ingest and load the local domain-specific model:
   ```bash
   docker logs -f agent-orchestrator-core
   ```

### Running a Validation Scan
Simulate an untrusted sub-agent attempting to inject a banned dependency license or a hardcoded secret by hitting the central FastAPI gateway:

```bash
curl -X POST "http://localhost:8000/arbitrate" \
     -H "Content-Type: application/json" \
     -d "{ \
       \"artifact_name\": \"package.json\", \
       \"content\": \"{\\\"dependencies\\\": {\\\"banned-copyleft\\\": \\\"GPL-3.0\\\"}}\" \
     }"
```

### The Traceability Ledger (Audit Log)
The Senior AI Orchestrator intercepts the request, runs the artifact through the Court of Arbitration, and prints a comprehensive tracking ledger detailing exactly **Who, What, Where, When, and Why** the file succeeded or failed:

```json
{
  "verdict": "REJECTED",
  "arbitration_timestamp": "2026-07-13T16:12:00.000Z",
  "evaluation_context": {
    "target_artifact": "package.json"
  },
  "decision_rationale": {
    "who": "Supply-Chain Inspector (SCA Sub-Agent)",
    "what": "Attempted introduction of banned license 'GPL-3.0'",
    "where": "Dependency Manifest Tree via `package.json`",
    "when": "Runtime Validation Phase Block",
    "why": "The artifact utilizes a GPL-3.0 copyleft license. This directly violates clause 4.2 of security-policy.json, which explicitly restricts intellectual property contamination."
  },
  "execution_trace_log": [
    {
      "step": 1,
      "submodule": "License Compliance Verification",
      "assertion": "Verify third-party licenses map cleanly to the allowed white-list array",
      "status": "FAIL",
      "evidence": "Detected 'GPL-3.0' inside dependency tree block."
    }
  ]
}
```
