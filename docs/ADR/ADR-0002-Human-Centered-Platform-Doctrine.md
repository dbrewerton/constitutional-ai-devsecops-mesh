# ADR-0002: Human-Centered Collaborative Platform Doctrine

## Status

Proposed

## Date

2026-07-20

## Decision Makers

- Daniel Brewerton — Human authority and architecture sponsor
- OpenAI engineering collaborator — Architecture, security, and documentation contributor

## Context

Human–AI collaborative products increasingly combine distributed data, local-first operation, personalized interfaces, AI guidance, international audiences, regulated third-party services, optional paid capabilities, and native distribution.

Without shared doctrine, these concerns are often implemented independently and late. That creates avoidable risks: split-brain data authority, manipulative or inaccessible motion, translation drift, accidental regulated-data scope, client-side entitlement bypass, overprivileged desktop shells, and undocumented assumptions.

The Constitutional AI DevSecOps Mesh already requires human authority, evidence, least privilege, privacy, separation of duties, auditability, and explicit uncertainty. A reusable subordinate doctrine is needed to apply those constitutional principles to human-facing collaborative platforms.

## Decision

Adopt `docs/doctrine/HUMAN-CENTERED-PLATFORM-DOCTRINE.md` as a proposed reusable doctrine governing:

- separation of durable data authority from elected operational leadership;
- auditable offline synchronization and conflict handling;
- internationalization and AI Translation Officer responsibilities;
- living, OS-like interfaces with user-controlled motion and accessibility protections;
- truthful trusted-companion behavior without fabricated personhood;
- outsourced payment-card processing and residual merchant governance;
- server-authoritative plugin entitlements;
- least-privilege cross-platform application packaging;
- required documentation and test evidence.

## Rationale

The doctrine turns product insights into reviewable organizational knowledge while respecting repository boundaries. It provides one authoritative reusable reference and allows each product repository to maintain its own implementation ADR, threat model, and acceptance evidence.

This approach also preserves the distinction between:

- constitutional governance;
- reusable doctrine;
- product architecture;
- implementation code;
- test evidence;
- human approval.

## Validation Strategy

The doctrine will be validated through:

1. Constitutional review against `docs/CONSTITUTION.md`.
2. Human review for scope, wording, and authority boundaries.
3. Application to at least one reference implementation.
4. Comparison of implementation evidence against doctrine requirements.
5. Revision when real operating evidence contradicts an assumption.

## Consequences

### Positive

- Distributed and AI-assisted products gain a common human-authority baseline.
- Translation, motion, payments, synchronization, plugins, and packaging are governed before production rollout.
- Product repositories can reference reusable doctrine instead of duplicating or drifting from policy.
- Reviewers can trace a product choice to doctrine and constitutional principles.

### Negative or costly

- Products must create and maintain implementation evidence.
- Language packs require governance and qualified review.
- Outsourced payments still require provider and merchant compliance work.
- Native distribution requires OS-specific builds, signing, and scanning.
- Some desired interface effects may be rejected for accessibility or truthfulness reasons.

## Alternatives Considered

### Keep all guidance in the DJ Intelligence repository

Rejected because the principles apply beyond one product and would be harder to discover, govern, and reuse.

### Amend the Constitution directly

Rejected for now because these are detailed application doctrines subordinate to existing constitutional principles, not a replacement of constitutional authority.

### Treat the ideas as informal design notes

Rejected because they affect data integrity, regulated-data boundaries, human trust, accessibility, and deployment architecture across multiple development cycles.

## Constitutional Alignment

This decision directly supports:

- Human Authority
- Least Privilege
- Separation of Duties
- Explainability
- Reproducibility
- Auditability
- Fail Safely
- No Silent Bypass
- Privacy and Data Handling
- Security Boundaries
- Change Governance

The doctrine remains subordinate to the Constitution. Any conflict must be recorded and resolved in favor of constitutional authority.

## Implementation

- Reusable doctrine: `docs/doctrine/HUMAN-CENTERED-PLATFORM-DOCTRINE.md`
- Product implementation ADR: maintained in the DJ Intelligence repository under `docs/ADR/ADR-0001-Platform-Authority-Sync-Localization-Payments-Distribution.md`
- Reference implementation branch: `agent/multi-op-event-client-foundation`

No product code, secrets, private event data, or client records are stored in this governance repository.

## Future Work

- Add a formal payment-provider responsibility matrix template.
- Add a language-pack manifest schema.
- Add synchronization conflict-classification guidance.
- Add accessible-motion test cases.
- Define executable policy checks for cross-platform capability manifests.
- Evaluate whether portions of this doctrine should later become constitutional amendments or machine-readable policy.

## Decision Summary

The project will govern human-facing collaborative platforms through a reusable doctrine that preserves human authority, durable data integrity, truthful interaction, accessibility, privacy, least privilege, and auditable third-party boundaries.
