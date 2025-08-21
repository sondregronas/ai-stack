# Get directory of this script
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$JsonFile  = Join-Path $ScriptDir "flux1dev-workflow.json"
$EnvFile   = Join-Path $ScriptDir "..\open-webui\comfy-workflow.env"

# Ensure JSON file exists
if (-not (Test-Path $JsonFile)) {
    Write-Error "JSON file not found: $JsonFile"
    exit 1
}

# Read and compact JSON
$WorkflowJson = Get-Content $JsonFile -Raw | ConvertFrom-Json | ConvertTo-Json -Compress

# Read current env file or initialize empty
if (Test-Path $EnvFile) {
    $Lines = Get-Content $EnvFile
} else {
    $Lines = @()
}

# Replace COMFYUI_WORKFLOW if exists, else append
$Found = $false
$UpdatedLines = $Lines | ForEach-Object {
    if ($_ -match '^COMFYUI_WORKFLOW=') {
        $Found = $true
        "COMFYUI_WORKFLOW=$WorkflowJson"
    } else {
        $_
    }
}
if (-not $Found) {
    $UpdatedLines += "COMFYUI_WORKFLOW=$WorkflowJson"
}

# Save updated env file
$UpdatedLines | Set-Content $EnvFile

Write-Output "COMFYUI_WORKFLOW updated in $EnvFile"
