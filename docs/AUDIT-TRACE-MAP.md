# Audit Trace Map

**Status:** Proposed index  
**Purpose:** Help reviewers locate governing authority, implementation evidence, human approval, and known gaps without searching every repository.

This map is an index. The linked records remain authoritative.

## Trace legend

| Status | Meaning |
|---|---|
| Proposed | Design or policy exists but is not accepted |
| Implemented — unverified | Code/configuration exists; evidence is incomplete |
| Test evidence available | Automated or human test evidence exists |
| Accepted | Authorized humans approved the control and evidence |
| Exception | Known gap accepted for a defined scope and period |
| Superseded | Replaced by a newer control or decision |

## Governance controls

| Control objective | Constitutional authority | Doctrine / ADR | Implementation or evidence | Human approval | Status / limitation |
|---|---|---|---|---|---|
| Final human authority | `docs/CONSTITUTION.md` | `docs/doctrine/HUMAN-CENTERED-PLATFORM-DOCTRINE.md`; ADR-0002 | Product approval gates and PR records | Required before acceptance or deployment | Proposed doctrine |
| Evidence before assertion | `docs/CONSTITUTION.md` | `docs/doctrine/AUDIT-EVIDENCE-AND-DECISION-TRACE.md`; ADR-0003 | CI reports, scanner artifacts, test outputs, audit exports | Reviewer verifies evidence | Proposed doctrine |
| One authoritative source per concept | `docs/CONSTITUTION.md` | Audit Evidence doctrine | Repository documentation maps and cross-references | Documentation review | Initial map only |
| Least privilege | `docs/CONSTITUTION.md` | Human-Centered Platform doctrine | Container users, DB grants, Tauri capabilities, network boundaries | Security review | Reference implementation in draft |
| Separation of duties | `docs/CONSTITUTION.md` | Both doctrines | Separate API/sync roles, environment promotion approvals, payment provider boundary | Human acceptance | Production roles not yet finalized |
| No silent bypass | `docs/CONSTITUTION.md` | Both doctrines | Conflict preservation, authorization gates, webhook verification | Security and operational review | Conflict resolution UI pending |
| Privacy minimization | `docs/CONSTITUTION.md` | Both doctrines | Prohibited data lists, safe browser profile, hosted payments, evidence minimization | Privacy review | Retention schedule pending |

## DJ Intelligence reference implementation

Repository: `dbrewerton/dj-planner-buildout`  
Draft implementation PR: `#10`

| Control objective | Product decision/specification | Code/configuration evidence | Automated evidence | Human evidence | Status / known gap |
|---|---|---|---|---|---|
| Shared data authority | `docs/ADR/ADR-0001-Platform-Authority-Sync-Localization-Payments-Distribution.md`; `docs/PLATFORM-FOUNDATION.md` | MySQL schema; API/sync services; internal database network | Encrypted integration workflow | Human multi-device test | Draft; production identity absent |
| Offline sync idempotency | `docs/SYNCHRONIZATION-PROTOCOL.md` | `sync_mutations`; browser pending idempotency key | Replay integration test | Network interruption test | Browser test session only |
| Conflict preservation | `docs/TRANSACTION-DECISION-TRACE.md` | `sync_conflicts`, variants, resolutions schema | Stale revision test | Resolution UI test | Schema foundation; API/UI population pending |
| Central Command election | Product ADR; sync protocol | Presence, ballots, terms, audit rows | Two-device quorum/election integration test | Device failover exercise | Test implementation |
| Internationalization | `docs/LANGUAGE-CODEX.md` | Locale registry and runtime | Quality-gate review status checks | Translation Officer + qualified human review | English canonical; Spanish pilot only |
| Living interface accessibility | Product ADR; platform foundation | Calm/Expressive/Off modes; reduced-motion protection | Syntax/quality checks | Keyboard, screen reader, vestibular testing | Human accessibility testing pending |
| Hosted payment boundary | `docs/PCI-PAYMENT-BOUNDARY.md` | Hosted Checkout adapter; verified webhook; entitlements | Unit/integration/security scans | Provider test-mode acceptance | PCI validation and live-mode approval pending |
| Native cross-platform shell | Product ADR; platform foundation | Tauri config and minimal capability | Linux compile and Trivy workflow | Windows/macOS/Linux installation tests | Icons, signing, and OS matrix pending |
| Cloud presence segregation | `docs/CLOUD-PRESENCES-AND-ENVIRONMENT-GOVERNANCE.md` | Future manifests and Docker networks | Future deployment policy tests | Dev/test/prod promotion approvals | Future architecture |
| Security evidence | `docs/SECURITY-TESTING.md` | GitHub Actions workflow | Semgrep, npm audit, Trivy, integration artifacts | Aikido review | CI remediation in progress |

## Environment promotion trace

Every environment promotion should link:

1. source revision;
2. dependency lockfiles;
3. container image digests;
4. configuration hash;
5. database migration set;
6. security evidence;
7. AI review and limitations;
8. human approval;
9. deployment result;
10. post-deployment verification or rollback.

No blank cell should be interpreted as passing. It is missing evidence until resolved.

## Audit package future

A future read-only audit export should include:

- this map and exact revisions;
- Constitution and applicable doctrines;
- accepted ADRs;
- threat model and data flows;
- deployment manifests;
- scanner summaries and original machine-readable reports;
- human approval records;
- decision/conflict artifacts;
- incident and exception records;
- retention and deletion evidence;
- known gaps and remediation status.

The export must reference private evidence through authorized access controls rather than copying secrets or unrelated personal data into the governance repository.
