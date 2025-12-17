
<# 
Bootstrap a Poetry-based data science environment on Windows.
Author: Brian’s Env
#>

# --- Safety: allow script for this session only ---
$previousPolicy = Get-ExecutionPolicy
if ($previousPolicy -ne 'Bypass') {
    try {
        Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
    } catch {
        Write-Warning "Execution policy change failed. You can run manually: Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass"
    }
}

# --- Helper: find poetry.exe after install ---
function Get-PoetryPath {
    $candidates = @(
        "$env:APPDATA\pypoetry\venv\Scripts\poetry.exe",
        "$env:APPDATA\Python\Scripts\poetry.exe"
    )
    foreach ($p in $candidates) {
        if (Test-Path $p) { return $p }
    }
    return $null
}

# --- 1) Install Poetry via official installer using the Python launcher ---
Write-Host "Installing Poetry..." -ForegroundColor Cyan
$installerUrl = 'https://install.python-poetry.org'
$installerFile = Join-Path $env:TEMP ("install-poetry-{0}.py" -f ([System.Guid]::NewGuid()))
Invoke-WebRequest -Uri $installerUrl -OutFile $installerFile

# Use the Python launcher to run the installer so PATH issues don’t matter.
& py $installerFile

# --- 2.5) Install Git for version control ---
Write-Host "Installing Git..." -ForegroundColor Cyan
winget install --id Git.Git -e --source winget --accept-source-agreements

# --- 3) Locate poetry.exe ---
$poetry = Get-PoetryPath
if (-not $poetry) {
    Write-Error "Poetry was not found after installation. Try opening a NEW PowerShell window or check $env:APPDATA\Python\Scripts."
    exit 1
}

# --- 3) Create project folder ---
$proj = "C:\Users\bbrewer1\ds-env"
if (-not (Test-Path $proj)) {
    New-Item -ItemType Directory -Path $proj | Out-Null
}
Set-Location $proj

# --- 4) Initialize Poetry project (non-interactive) ---
& $poetry init --name "ds-env" --description "Data science env (numpy, pandas, matplotlib, seaborn, scikit-learn) for JupyterLab" --license "Proprietary" --no-interaction

# --- 5) Keep virtualenv inside the project ---
& $poetry config virtualenvs.in-project true

# --- 6) Use Python 3.14 for the environment (will select your 3.14.2) ---
# If multiple Pythons exist, you can change to a specific path later: poetry env use <full-path-to-python.exe>
& $poetry env use 3.14

# --- 7) Add core DS stack ---
Write-Host "Installing data science packages..." -ForegroundColor Cyan
& $poetry add numpy pandas matplotlib seaborn scikit-learn

# --- 8) Add JupyterLab and ipykernel ---
& $poetry add jupyterlab ipykernel

# --- 9) Register a Jupyter kernel (visible in JupyterLab) ---
$kernelName   = "ds-env-py314"
$displayName  = "ds-env (Python 3.14)"
& $poetry run python -m ipykernel install --user --name $kernelName --display-name "$displayName"

# --- 10) Launch JupyterLab using the environment ---
Write-Host "Launching JupyterLab from the ds-env virtual environment..." -ForegroundColor Green
& $poetry run jupyter lab
``
