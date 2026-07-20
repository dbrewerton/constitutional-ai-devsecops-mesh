# ADR-0003: Audit Evidence and Decision Trace Doctrine

## Status

Proposed

## Date

2026-07-20

## Decision Makers

- Daniel Brewerton — Human authority, Certified IT Auditor, and Fraud Detection Specialist
- OpenAI engineering collaborator — Architecture, security, and documentation contributor

## Context

A secure system can still be expensive and difficult to audit when intent, policy, implementation, automated evidence, approvals, operational outcomes, and known limitations are scattered across repositories and tools.

Human–AI collaboration adds another risk: consequential reasoning may remain trapped in conversation history or be presented later as if it were contemporaneous evidence. Distributed devices add clock skew, retries, concurrent edits, and competing versions. Multiple environments add promotion and segregation-of-duties requirements.

The Constitution already requires evidence, auditability, reproducibility, human authority, privacy, and no silent bypass. A reusable subordinate doctrine is needed to define the trace structure connecting those principles to implementation and operational evidence.

## Decision

Adopt `docs/doctrine/AUDIT-EVIDENCE-AND-DECISION-TRACE.md` as a proposed doctrine.

The doctrine requires:

- one authoritative source per material concept;
- a trace chain from human intent through policy, ADR, implementation, evidence, approval, deployment, and retrospective;
- causal ordering based on revisions and authoritative sequences rather than wall-clock precision alone;
- preservation of competing changes and static decisional-tree artifacts;
- independent development, test, and production control domains;
- protected administrative tooling;
- privacy-minimized evidence;
- explicit fraud/anomaly indicators without automatic accusation;
- an audit trace map as a discoverability index.

## Rationale

A clear trace lowers audit discovery cost and improves the quality of review. It does not make an audit a rubber stamp; it makes the controls and gaps easy to test.

The design also improves legal and regulatory defensibility by separating:

- contemporaneous evidence;
- human decisions;
- AI recommendations;
- later interpretation;
- unresolved uncertainty.

## Validation Strategy

1. Build and maintain `docs/AUDIT-TRACE-MAP.md`.
2. Apply the trace to the DJ Intelligence reference implementation.
3. Confirm every mapped control links to its governing record and evidence.
4. Test concurrent-change decision artifacts and independently verify hashes.
5. Test environment promotion records and approval boundaries.
6. Conduct an independent audit-style review without relying on conversation memory.
7. Record any missing evidence as findings rather than filling gaps retrospectively.

## Consequences

### Positive

- Auditors and reviewers can locate evidence quickly.
- Human and AI roles remain distinguishable.
- Concurrent modifications preserve provenance and resolution rationale.
- Environment promotions become reproducible and accountable.
- Fraud and replay investigations gain stronger evidence.
- Legal assertions can be tied to contemporaneous records.

### Costs and limitations

- Evidence schemas and indexes require maintenance.
- Retention and privacy rules become more important as trace quality improves.
- Artifact signing and independent time services may add future complexity.
- A well-organized trace can still reveal a real control failure; discoverability is not compliance.

## Alternatives Considered

### Depend on application logs

Rejected because logs are usually too broad, mutable, noisy, and disconnected from intent and approval.

### Depend on Git history and pull requests

Rejected because source-control evidence does not fully capture runtime decisions, environment configuration, data conflicts, deployments, or incidents.

### Reconstruct evidence only when an audit occurs

Rejected because retrospective reconstruction risks missing context, unintentional backdating, hidden uncertainty, and unverifiable claims.

### Use nanosecond timestamps as the ordering authority

Rejected because device clocks can drift and network delivery can reorder transactions. High-resolution timing remains supporting evidence; revisions and authoritative sequences establish causality.

## Constitutional Alignment

This decision supports:

- Human Authority
- Evidence Before Assertion
- Explainability
- Reproducibility
- Auditability
- Least Privilege
- Separation of Duties
- Fail Safely
- No Silent Bypass
- Privacy and Data Handling
- Change Governance

The doctrine remains subordinate to the Constitution.

## Implementation

- Doctrine: `docs/doctrine/AUDIT-EVIDENCE-AND-DECISION-TRACE.md`
- Audit index: `docs/AUDIT-TRACE-MAP.md`
- Reference product implementation:
  - `dj-planner-buildout/docs/TRANSACTION-DECISION-TRACE.md`
  - `dj-planner-buildout/docs/CLOUD-PRESENCES-AND-ENVIRONMENT-GOVERNANCE.md`
  - `dj-planner-buildout/docs/ADR/ADR-0001-Platform-Authority-Sync-Localization-Payments-Distribution.md`

## Future Work

- Define a machine-readable audit-map schema.
- Define canonical JSON and signing requirements for decision artifacts.
- Evaluate trusted timestamping for high-risk artifacts.
- Add evidence-retention and legal-hold templates.
- Add an auditor read-only role and evidence export package.
- Add policy checks for environment isolation and promotion manifests.

## Decision Summary

The project will treat auditability as an architectural property and preserve a clear, privacy-minimized, tamper-evident trace from human intent to operational outcome.