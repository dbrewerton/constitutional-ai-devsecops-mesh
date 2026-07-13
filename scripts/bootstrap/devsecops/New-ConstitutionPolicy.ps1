<#
.SYNOPSIS
Creates the machine-readable constitutional policy file.

.DESCRIPTION
Creates config/constitution.yaml relative to the project root.

The script:
- Detects the project root automatically.
- Creates the config directory if it does not exist.
- Refuses to overwrite an existing non-empty file unless -Force is used.
- Writes through a temporary file.
- Uses UTF-8 without a byte-order mark.
- Performs structural validation without requiring an external YAML module.

.PARAMETER ProjectRoot
Optional explicit path to the project root.

.PARAMETER Force
Allows replacement of an existing non-empty policy file.

.EXAMPLE
.\scripts\bootstrap\devsecops\New-ConstitutionPolicy.ps1

.EXAMPLE
.\scripts\bootstrap\devsecops\New-ConstitutionPolicy.ps1 -Force
#>

[CmdletBinding()]
param(
    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [string]$ProjectRoot,

    [Parameter()]
    [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$temporaryPath = $null

function Resolve-DevSecOpsProjectRoot {
    [CmdletBinding()]
    param(
        [Parameter()]
        [string]$ExplicitProjectRoot
    )

    if ($ExplicitProjectRoot) {
        return (Resolve-Path -LiteralPath $ExplicitProjectRoot -ErrorAction Stop).Path
    }

    # Expected location:
    # <project-root>/scripts/bootstrap/devsecops/New-ConstitutionPolicy.ps1
    $candidateRoot = Split-Path -Parent $PSScriptRoot
    $candidateRoot = Split-Path -Parent $candidateRoot
    $candidateRoot = Split-Path -Parent $candidateRoot

    if (-not (Test-Path -LiteralPath $candidateRoot -PathType Container)) {
        throw "Unable to determine project root from script location: $PSScriptRoot"
    }

    return (Resolve-Path -LiteralPath $candidateRoot).Path
}

function Write-Utf8WithoutBom {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Path,

        [Parameter(Mandatory)]
        [AllowEmptyString()]
        [string]$Content
    )

    $encoding = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllText($Path, $Content, $encoding)
}

function Test-ConstitutionPolicyStructure {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Content
    )

    $requiredPatterns = [ordered]@{
        Version                  = '(?m)^version:\s*"0\.1\.0"\s*$'
        Status                   = '(?m)^status:\s*"draft"\s*$'
        ConstitutionReference    = '(?m)^constitution_reference:\s*"docs/CONSTITUTION\.md"\s*$'
        Governance               = '(?m)^governance:\s*$'
        EvidenceRequired         = '(?m)^\s{2}evidence_required:\s*true\s*$'
        AiIsNotEvidence          = '(?m)^\s{2}ai_output_is_evidence:\s*false\s*$'
        HumanAuthority           = '(?m)^\s{2}human_final_authority:\s*true\s*$'
        RealFramework            = '(?m)^real_framework:\s*$'
        Confidence               = '(?m)^confidence:\s*$'
        AgentControls            = '(?m)^agent_controls:\s*$'
        HumanReview              = '(?m)^human_review:\s*$'
        SecurityBoundaries       = '(?m)^security_boundaries:\s*$'
        Violations               = '(?m)^constitutional_violations:\s*$'
        Reporting                = '(?m)^reporting:\s*$'
        Audit                    = '(?m)^audit:\s*$'
    }

    $missing = @()

    foreach ($entry in $requiredPatterns.GetEnumerator()) {
        if ($Content -notmatch $entry.Value) {
            $missing += $entry.Key
        }
    }

    return $missing
}

try {
    $resolvedProjectRoot = Resolve-DevSecOpsProjectRoot `
        -ExplicitProjectRoot $ProjectRoot

    $configDirectory = Join-Path $resolvedProjectRoot 'config'
    $destinationPath = Join-Path $configDirectory 'constitution.yaml'
    $temporaryPath = "$destinationPath.tmp"

    if (-not (Test-Path -LiteralPath $configDirectory -PathType Container)) {
        New-Item `
            -ItemType Directory `
            -Path $configDirectory `
            -Force |
            Out-Null
    }

    if (Test-Path -LiteralPath $destinationPath -PathType Leaf) {
        $existingFile = Get-Item -LiteralPath $destinationPath

        if (($existingFile.Length -gt 0) -and (-not $Force)) {
            throw @"
The destination file already exists and is not empty:

$destinationPath

No changes were made. Use -Force only when replacement is intentional.
"@
        }
    }

    $policyContent = @'
version: "0.1.0"
status: "draft"
constitution_reference: "docs/CONSTITUTION.md"

metadata:
  name: "Constitutional AI DevSecOps Mesh Policy"
  document_type: "machine-readable constitutional policy"
  authority: "project constitution"
  schema_version: "0.1.0"

governance:
  constitution_is_highest_authority: true
  evidence_required: true
  ai_output_is_evidence: false
  human_final_authority: true
  skeptical_acceptance_required: true
  silent_policy_bypass_forbidden: true
  unsupported_certainty_forbidden: true
  unresolved_disagreement_must_be_visible: true
  consequential_actions_fail_closed: true

scope:
  local_first: true
  kubernetes_required: false
  cloud_required: false

  permitted:
    - "inspect_authorized_repositories"
    - "run_isolated_security_tools"
    - "normalize_findings"
    - "validate_evidence"
    - "evaluate_policy"
    - "produce_reports"
    - "preserve_audit_records"
    - "recommend_remediation"

  prohibited_without_human_approval:
    - "modify_source_code"
    - "modify_infrastructure"
    - "deploy_software"
    - "perform_destructive_actions"
    - "suppress_verified_findings"
    - "accept_constitutional_exceptions"

real_framework:
  required: true

  real:
    description: "Confirm that the reported condition exists in the authorized target."
    required_checks:
      - "target_exists"
      - "artifact_exists"
      - "artifact_is_in_scope"
      - "reported_location_is_relevant"

  evidence:
    description: "Identify verifiable artifacts supporting the claim."
    required_checks:
      - "evidence_present"
      - "evidence_origin_recorded"
      - "evidence_distinguished_from_interpretation"
      - "evidence_integrity_recorded_when_practical"

  auditable:
    description: "Preserve enough provenance for independent review."
    required_checks:
      - "tool_identity_recorded"
      - "tool_version_recorded"
      - "policy_version_recorded"
      - "target_revision_recorded"
      - "decision_path_recorded"
      - "timestamps_recorded"

  logical:
    description: "Ensure the conclusion follows from the evidence."
    required_checks:
      - "severity_supported"
      - "confidence_supported"
      - "impact_supported"
      - "recommendation_supported"
      - "unsupported_inference_absent"

confidence:
  minimum: 0.0
  maximum: 1.0
  derivation_required: true

  classifications:
    insufficient_evidence:
      minimum: 0.0
      maximum: 0.39

    tentative:
      minimum: 0.40
      maximum: 0.69

    supported:
      minimum: 0.70
      maximum: 0.89

    verified:
      minimum: 0.90
      maximum: 1.0

  reduction_conditions:
    - "required_evidence_missing"
    - "tools_disagree"
    - "reproduction_failed"
    - "target_not_confirmed"
    - "rule_applicability_uncertain"
    - "unsupported_inference_required"

agent_controls:
  identity_required: true
  declared_capability_required: true
  approved_schema_required: true
  least_privilege_required: true
  resource_limits_required: true
  uncertainty_reporting_required: true
  provenance_required: true

  must:
    - "accept_only_authorized_work"
    - "operate_within_declared_capability"
    - "distinguish_fact_evidence_interpretation_recommendation"
    - "report_errors_and_limitations"
    - "preserve_relevant_provenance"
    - "respect_execution_limits"

  must_not:
    - "fabricate_evidence"
    - "fabricate_sources"
    - "fabricate_confidence"
    - "conceal_failed_checks"
    - "conceal_disagreement"
    - "act_outside_scope"
    - "bypass_human_approval"
    - "claim_unsupported_certainty"
    - "suppress_findings_for_appearance"

  may:
    - "request_additional_evidence"
    - "challenge_another_agent"
    - "downgrade_confidence"
    - "escalate_disagreement"
    - "refuse_unsafe_work"
    - "refuse_unconstitutional_work"

decision_lifecycle:
  required_stages:
    - "authorized_intent"
    - "scope_establishment"
    - "evidence_collection"
    - "finding_normalization"
    - "evidence_validation"
    - "real_evaluation"
    - "policy_evaluation"
    - "disagreement_recording"
    - "decision_or_recommendation"
    - "human_review_when_required"
    - "report_generation"
    - "audit_preservation"

  allow_return_to_prior_stage: true
  unresolved_state_is_valid: true
  fabricated_consensus_forbidden: true

human_review:
  required_for:
    - "source_code_modification"
    - "infrastructure_modification"
    - "deployment"
    - "destructive_action"
    - "constitutional_exception"
    - "suppression_of_verified_finding"
    - "consequential_unresolved_disagreement"
    - "policy_designated_action"

  approval_record_requires:
    - "decision_id"
    - "approver_identity"
    - "timestamp"
    - "scope"
    - "conditions"

security_boundaries:
  repository_mount_read_only_preferred: true
  non_root_execution_required: true
  drop_linux_capabilities: true
  explicit_network_access_required: true
  resource_limits_required: true
  temporary_working_storage_preferred: true
  unrestricted_host_filesystem_forbidden: true
  unrestricted_container_socket_forbidden: true
  versioned_tool_images_preferred: true
  integrity_controlled_images_preferred: true

privacy:
  data_minimization_required: true
  unnecessary_secret_repetition_forbidden: true
  report_redaction_required_when_practical: true
  prompt_secret_exposure_forbidden: true
  sensitive_log_exposure_forbidden: true

constitutional_violations:
  stop_consequential_workflow: true
  record_violation: true
  surface_for_human_review: true

  examples:
    - "finding_accepted_without_required_evidence"
    - "ai_output_presented_as_evidence"
    - "confidence_fabricated_or_inflated"
    - "uncertainty_hidden"
    - "tool_disagreement_hidden"
    - "authorized_scope_exceeded"
    - "human_approval_bypassed"
    - "audit_information_suppressed"
    - "unauthorized_modification_performed"
    - "execution_failure_concealed"
    - "undocumented_exception_applied"
    - "least_privilege_violated"

exceptions:
  human_approval_required: true
  must_be_specific: true
  must_be_auditable: true
  time_bounded_preferred: true

  required_fields:
    - "rule"
    - "reason"
    - "scope"
    - "approver"
    - "approval_timestamp"
    - "expiration_or_review_condition"
    - "compensating_controls"
    - "associated_risks"

reporting:
  technical_report_required: true
  plain_language_report_required: true
  uncertainty_must_be_visible: true
  evidence_must_be_distinguishable: true
  interpretation_must_be_distinguishable: true

  required_sections:
    - "raw_evidence"
    - "normalized_findings"
    - "validation_results"
    - "policy_results"
    - "confidence"
    - "severity"
    - "recommendations"
    - "human_decisions"
    - "remaining_uncertainty"

audit:
  required: true
  immutable_preferred: true

  required_fields:
    - "scan_id"
    - "decision_id"
    - "target"
    - "target_revision"
    - "tool_identity"
    - "tool_version"
    - "policy_version"
    - "evidence_references"
    - "validation_results"
    - "decision_state"
    - "confidence"
    - "timestamps"
    - "human_approval_state"

change_governance:
  explicit_proposal_required: true
  security_review_required: true
  operational_review_required: true
  version_control_required: true
  rationale_required: true
  human_approval_required: true

  semantic_versioning:
    major: "breaking constitutional change"
    minor: "material compatible governance change"
    patch: "correction without change in meaning"
'@

    if (Test-Path -LiteralPath $temporaryPath) {
        Remove-Item -LiteralPath $temporaryPath -Force
    }

    Write-Utf8WithoutBom `
        -Path $temporaryPath `
        -Content $policyContent

    if (-not (Test-Path -LiteralPath $temporaryPath -PathType Leaf)) {
        throw "Temporary policy file was not created: $temporaryPath"
    }

    $temporaryFile = Get-Item -LiteralPath $temporaryPath

    if ($temporaryFile.Length -eq 0) {
        throw 'The generated constitutional policy file is empty.'
    }

    $generatedContent = Get-Content -LiteralPath $temporaryPath -Raw

    if ($generatedContent -match "`t") {
        throw 'YAML validation failed: tab characters are not permitted.'
    }

    $missingSections = Test-ConstitutionPolicyStructure `
        -Content $generatedContent

if (@($missingSections).Count -gt 0) {
	throw (
            'Policy validation failed. Missing or invalid sections: {0}' -f
            ($missingSections -join ', ')
        )
    }

    Move-Item `
        -LiteralPath $temporaryPath `
        -Destination $destinationPath `
        -Force

    $completedFile = Get-Item -LiteralPath $destinationPath
    $hash = Get-FileHash `
        -LiteralPath $destinationPath `
        -Algorithm SHA256

    Write-Host ''
    Write-Host 'Constitutional AI DevSecOps Mesh'
    Write-Host '================================'
    Write-Host '[PASS] Machine-readable policy created'
    Write-Host "[INFO] Project root: $resolvedProjectRoot"
    Write-Host "[INFO] File: $destinationPath"
    Write-Host "[INFO] Size: $($completedFile.Length) bytes"
    Write-Host "[INFO] SHA-256: $($hash.Hash)"
    Write-Host '[PASS] Required policy sections validated'
    Write-Host '[PASS] YAML contains no tab indentation'
    Write-Host ''
}
catch {
    if ($temporaryPath -and (Test-Path -LiteralPath $temporaryPath)) {
        Remove-Item `
            -LiteralPath $temporaryPath `
            -Force `
            -ErrorAction SilentlyContinue
    }

    Write-Error "Constitution policy creation failed: $($_.Exception.Message)"
    exit 1
}