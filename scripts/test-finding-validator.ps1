[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'

$ComposeFile = Join-Path $PSScriptRoot '..\docker-compose.yml'
$ValidFinding = 'tests/fixtures/findings/valid-finding.json'
$InvalidFinding = 'tests/fixtures/findings/invalid-finding.json'
$MissingFinding = 'tests/fixtures/findings/does-not-exist.json'
$MalformedFinding = 'tests/fixtures/findings/malformed-finding.json'

function Invoke-ValidatorTest {
    param(
        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory)]
        [string]$FindingPath,

        [Parameter(Mandatory)]
        [int]$ExpectedExitCode
    )

    Write-Host ""
    Write-Host "Running: $Name"
    Write-Host "Finding: $FindingPath"

    docker compose `
        --file $ComposeFile `
        --profile tools `
        run `
        --rm `
        finding-validator `
        $FindingPath

    $ActualExitCode = $LASTEXITCODE

    if ($ActualExitCode -ne $ExpectedExitCode) {
        Write-Host "[FAIL] $Name"
        Write-Host "Expected exit code: $ExpectedExitCode"
        Write-Host "Actual exit code:   $ActualExitCode"
        return $false
    }

    Write-Host "[PASS] $Name"
    return $true
}

$Results = @()

$Results += Invoke-ValidatorTest `
    -Name 'Valid finding is accepted' `
    -FindingPath $ValidFinding `
    -ExpectedExitCode 0

$Results += Invoke-ValidatorTest `
    -Name 'Invalid finding is rejected' `
    -FindingPath $InvalidFinding `
    -ExpectedExitCode 1

$Results += Invoke-ValidatorTest `
    -Name 'Missing finding is rejected' `
    -FindingPath $MissingFinding `
    -ExpectedExitCode 2

$Results += Invoke-ValidatorTest `
    -Name 'Malformed JSON is rejected' `
    -FindingPath $MalformedFinding `
    -ExpectedExitCode 2

Write-Host ""
Write-Host "Finding Validator Test Summary"
Write-Host "=============================="

$Passed = ($Results | Where-Object { $_ -eq $true }).Count
$Failed = ($Results | Where-Object { $_ -eq $false }).Count

Write-Host "Passed: $Passed"
Write-Host "Failed: $Failed"

if ($Failed -gt 0) {
    exit 1
}

Write-Host ""
Write-Host "[PASS] All validator contract tests completed successfully."
exit 0