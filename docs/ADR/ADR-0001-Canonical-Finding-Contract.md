# ADR-0001: Canonical Finding Contract

**Status:** Accepted

**Date:** 2026-07-13

**Decision Makers:** Lighthouse Engineering / Constitutional AI DevSecOps Mesh

---

# Context

The Constitutional AI DevSecOps Mesh consists of multiple independent AI agents responsible for analyzing different aspects of software security. Examples include:

* Static Application Security Testing (SAST)
* Software Composition Analysis (SCA)
* Secret Detection
* Infrastructure as Code (IaC) Analysis
* Container Security
* Policy Evaluation
* Evidence Collection

Each tool naturally produces its own output format, terminology, confidence scoring, and metadata.

Without a common contract, the Supervisor would require custom logic for every scanner, increasing complexity, reducing reliability, and making independent validation difficult.

The project requires a stable, technology-agnostic interface between agents.

---

# Decision

All security findings exchanged within the Constitutional AI DevSecOps Mesh SHALL conform to a single versioned JSON Schema.

Current schema:

```
schemas/finding.schema.json
```

Every agent is responsible for translating its native output into the canonical finding format before submitting findings to the Supervisor.

The Supervisor SHALL reject findings that do not satisfy the schema.

---

# Rationale

The canonical finding contract provides:

* A stable interface between independently developed agents.
* Language and tool independence.
* Version-controlled evolution of the finding format.
* Simplified Supervisor implementation.
* Deterministic validation before processing.
* Improved interoperability between future scanners.
* Consistent evidence handling.
* Consistent severity and confidence representation.
* Repeatable automated testing.

---

# Validation Strategy

Validation is performed by a dedicated containerized validator.

Characteristics include:

* Docker-based execution
* No dependency on host-installed Python
* JSON Schema Draft 2020-12 validation
* Automated execution in CI
* Deterministic exit codes

Validation currently covers:

* Valid finding acceptance
* Schema violations
* Missing input files
* Malformed JSON documents

---

# Consequences

## Positive

* Strong contract between all mesh components.
* Easier onboarding of new scanners.
* Reduced coupling between agents.
* Easier automated testing.
* Better auditability.
* Predictable machine-readable outputs.
* Consistent evidence requirements.

## Negative

* All agents must perform schema translation.
* Schema changes require version management.
* Additional validation step during processing.

These tradeoffs are accepted in exchange for improved governance and long-term maintainability.

---

# Alternatives Considered

## Native Scanner Formats

Rejected because every scanner uses different field names, severity models, and metadata.

This would tightly couple the Supervisor to individual tools.

---

## Multiple Internal Contracts

Rejected because maintaining several internal contracts increases complexity and duplicates validation logic.

---

## Direct Tool-to-Supervisor Integration

Rejected because it creates long-term maintenance costs and prevents independent evolution of agents.

---

# Constitutional Alignment

This decision supports the constitutional principles of:

* Evidence before conclusion
* Deterministic processing
* Explicit contracts
* Explainability
* Traceability
* Separation of responsibilities
* Documentation-first engineering

---

# Implementation

Implemented components include:

* `schemas/finding.schema.json`
* `validator/Dockerfile`
* `validator/requirements.txt`
* `scripts/validate-findings.py`
* `scripts/test-finding-validator.ps1`
* `tests/fixtures/findings/`
* `.github/workflows/finding-validator.yml`

---

# Future Work

Future ADRs are expected to cover:

* Supervisor architecture
* Evidence correlation
* Constitutional policy engine
* Kubernetes deployment model
* Agent authentication
* Inter-agent messaging
* Trust and confidence scoring
* Resource governance
* Audit logging
* Knowledge provenance

---

# Decision Summary

The Constitutional AI DevSecOps Mesh adopts a single, versioned, validated JSON finding contract as the authoritative interface between all agents.

All findings must satisfy this contract before they may participate in constitutional review or Supervisor orchestration.
