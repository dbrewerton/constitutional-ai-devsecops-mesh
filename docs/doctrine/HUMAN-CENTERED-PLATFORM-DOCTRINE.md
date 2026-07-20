# Human-Centered Collaborative Platform Doctrine

**Status:** Proposed  
**Date:** 2026-07-20  
**Authority:** Subordinate doctrine under the Constitutional AI DevSecOps Mesh Constitution  
**Applicability:** Human–AI collaborative products, operational platforms, and reference implementations

## 1. Purpose

This doctrine defines reusable engineering principles for platforms intended to feel supportive, responsive, and collaborative while preserving human authority, truthfulness, privacy, security, accessibility, and auditability.

A system may be warm, engaging, contextual, and adaptive. It must not earn trust through concealment, fabricated personhood, unsupported certainty, coercive design, or removal of meaningful human choice.

## 2. Human–AI collaborative identity

A trusted-companion experience is created through:

- continuity of context;
- clear explanations;
- respectful language;
- appropriate encouragement;
- visible uncertainty;
- useful recommendations;
- memory and personalization under user control;
- predictable recovery from failure;
- direct access to manual control.

It is not created by falsely claiming:

- consciousness;
- human identity;
- emotions the system does not possess;
- independent moral authority;
- approval that a human did not grant;
- certainty unsupported by evidence.

The interface may reduce the user's need to think about implementation details, but it shall not conceal the existence or limits of automation when those facts are material to a decision.

## 3. Data authority and operational leadership

Distributed platforms shall distinguish **data authority** from **operational leadership**.

A leader-elected device or agent may coordinate time-sensitive work, heartbeats, bounded continuity, failover, and communication. Election shall not silently create a new authoritative database or permit a leader to bypass durable validation.

Authoritative records shall have one governed commit path. Local replicas and offline working copies shall retain provenance, revision information, actor identity, device identity, and idempotency information sufficient to reconcile changes.

Leader election shall include:

- eligibility criteria;
- ballots or equivalent evidence;
- term and heartbeat boundaries;
- deterministic tie-breaking;
- failover behavior;
- visible leader identity;
- audit events;
- a prohibition against treating leader status as organization-wide authorization.

## 4. Synchronization doctrine

Synchronization shall be designed as an auditable exchange of changes rather than an unbounded overwrite of state.

Each durable change should identify:

- organization or tenant scope;
- entity and event scope;
- base revision;
- resulting revision;
- actor;
- originating device;
- timestamp;
- idempotency key;
- operation type;
- relevant validation result.

Push mechanisms such as server-sent events, WebSockets, or local-network notifications may indicate that new data is available. A push notification is not itself authoritative data and shall not grant permission.

Conflicts shall be:

- merged only when rules are deterministic and lossless;
- preserved when competing edits contain distinct information;
- escalated to human review when business meaning, client intent, safety, or event execution could change;
- recorded rather than silently discarded.

## 5. Internationalization and localization doctrine

Internationalization is an architectural responsibility, not a final translation step.

Platforms shall use:

- stable translation keys;
- BCP 47-compatible language tags;
- locale-aware formatting for dates, times, numbers, currency, lists, and sorting;
- direction metadata for left-to-right and right-to-left interfaces;
- pluralization and grammatical context;
- terminology notes where words carry professional, cultural, legal, or safety meaning;
- versioned language packs;
- review status and provenance for every pack.

Machine translation may produce a draft. A translation draft shall remain distinguishable from human-reviewed production language.

### AI Translation Officer

An AI Translation Officer may:

- maintain a Language Codex;
- propose translations;
- detect inconsistent terminology;
- preserve context and disallowed ambiguity;
- identify culturally sensitive wording;
- compare language-pack coverage;
- recommend review priorities.

The Translation Officer may not certify its own output as final human-quality translation. Production approval remains with authorized human reviewers, including native or professionally qualified reviewers when the risk or audience warrants it.

## 6. Living interface doctrine

A platform may use motion, depth, transitions, ambient visual feedback, and OS-like window behavior to communicate continuity and state.

Motion shall be:

- optional;
- user-selectable;
- compatible with `prefers-reduced-motion`;
- non-blocking;
- consistent with actual state;
- free of artificial urgency;
- safe for keyboard and assistive-technology users;
- tested for photosensitivity and vestibular concerns.

Visual warmth shall not reduce contrast, obscure controls, hide audit information, or make a consequential recommendation appear inevitable.

The system should feel alive because it responds coherently—not because it distracts the user.

## 7. Payment-card and regulated-data boundary

Where a specialized validated provider can safely perform a regulated function, the platform should prefer a clearly bounded provider integration over recreating that function without a compelling mission need.

For payment cards:

- cardholder data shall not enter the product's application code, API, logs, database, analytics, support tooling, or AI context;
- checkout should occur on a PCI DSS validated third-party hosted payment page;
- product prices and entitlements remain server authoritative;
- successful browser navigation shall not be treated as proof of payment;
- provider webhooks shall be authenticated, idempotent, and matched to server-created transactions;
- provider compliance and shared responsibilities shall be reviewed at least as required by applicable standards, acquirers, and contractual obligations.

Outsourcing payment processing reduces technical scope. It does not erase merchant responsibility for provider governance, redirect integrity, vulnerability management, written responsibility allocation, or required compliance validation.

## 8. Portable distribution doctrine

Write-once-run-across-platforms is a portability objective, not permission to flatten security differences between operating systems.

A portable application should:

- keep the primary user experience in a shared codebase;
- generate installers from a whitelisted artifact set;
- exclude source repositories, secrets, migrations, private exports, and development tooling;
- use least-privilege native capabilities;
- avoid shell, filesystem, process, clipboard, and updater permissions unless justified by a reviewed feature;
- build and sign on appropriate trusted runners for each target OS;
- scan dependencies and final binaries;
- preserve platform-specific accessibility and security controls;
- support PWA operation when native installation is unnecessary.

## 9. Plugin and entitlement doctrine

Optional capabilities may be free, paid, promotional, or administratively granted.

Entitlements shall be:

- server authoritative;
- organization- or user-scoped as explicitly designed;
- auditable;
- revocable;
- version-aware;
- separable from client-side presentation;
- incapable of being granted by changing browser storage or interface markup.

A plugin marketplace shall not become a path for arbitrary code execution. Executable extensions require a separately governed trust, signing, sandboxing, permission, update, and revocation model.

## 10. Documentation and evidence

A platform adopting this doctrine should maintain:

- an implementation ADR;
- a threat model;
- data-flow diagrams;
- synchronization and conflict rules;
- language-pack governance;
- accessibility and motion acceptance criteria;
- payment-provider responsibility matrix;
- distribution and code-signing procedures;
- SAST, SCA, DAST, and human-test evidence;
- explicit human approval records.

Documentation is an active control. A feature is not complete when its operating assumptions exist only in a conversation or an agent's memory.

## 11. Constitutional test

Before accepting a collaborative platform feature, reviewers shall ask:

1. Does the feature preserve meaningful human authority?
2. Is the data authority explicit and auditable?
3. Can offline and distributed changes be reconciled without silent loss?
4. Does the interface communicate truth rather than manufacture trust?
5. Can users reduce or disable motion?
6. Are language and cultural assumptions visible and governed?
7. Is regulated data kept outside the platform wherever practical?
8. Are native capabilities limited to the minimum required?
9. Can paid access be verified independently of the browser?
10. Have both automated evidence and human review been recorded?

A negative or unresolved answer is a reason to retain the feature in a proposed or test state rather than represent it as production-ready.

## 12. Reference implementation

The DJ Intelligence multi-client platform is an early reference implementation of this doctrine. Product-specific implementation details remain in its own repository. This governance repository records reusable principles only and does not absorb product code or private client data.
