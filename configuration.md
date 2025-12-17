# Local Setup Guide (No Admin Required)

This document captures the steps we used (and recommended) to get Git, Poetry, and Jupyter working without administrator rights on Windows.

## Git (No‑Admin Install)

We installed Git user‑local using the official Git for Windows portable builds. Prefer PortableGit (includes Git Bash). If blocked, use MinGit (CLI‑only).

- PortableGit (self‑extractor):
```powershell
# Create install folder
New-Item -ItemType Directory -Path "$env:USERPROFILE\Apps\Git\PortableGit" -Force | Out-Null
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Download latest PortableGit x64 self-extracting archive
$rel = Invoke-RestMethod https://api.github.com/repos/git-for-windows/git/releases/latest
$asset = $rel.assets | Where-Object { $_.name -like 'PortableGit-*-64-bit.7z.exe' } | Select-Object -First 1
Invoke-WebRequest -Uri $asset.browser_download_url -OutFile "$env:TEMP\PortableGit.exe"

# Extract (no admin)
Start-Process -FilePath "$env:TEMP\PortableGit.exe" -ArgumentList @('-y', "-o$env:USERPROFILE\Apps\Git\PortableGit") -Wait

# Add to PATH for session + persist for user
$gitCmd = "$env:USERPROFILE\Apps\Git\PortableGit\cmd"
$env:Path = "$gitCmd;$env:Path"
$old = [Environment]::GetEnvironmentVariable('Path','User')
if ($old -notlike "*$gitCmd*") { [Environment]::SetEnvironmentVariable('Path', "$gitCmd;$old", 'User') }

# Verify
git --version
```

- MinGit (fallback, CLI‑only, used successfully):
```powershell
$ErrorActionPreference = 'Stop'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$base = Join-Path $env:USERPROFILE 'Apps\Git'
New-Item -ItemType Directory -Path $base -Force | Out-Null
$outDir = Join-Path $base 'MinGit'
New-Item -ItemType Directory -Path $outDir -Force | Out-Null

# Get latest MinGit busybox 64-bit ZIP
$release = Invoke-RestMethod -Uri 'https://api.github.com/repos/git-for-windows/git/releases/latest'
$mingit = $release.assets | Where-Object { $_.name -like 'MinGit-*-busybox-64-bit.zip' } | Select-Object -First 1
$zip = Join-Path $env:TEMP $mingit.name

Invoke-WebRequest -Uri $mingit.browser_download_url -OutFile $zip
Expand-Archive -Path $zip -DestinationPath $outDir -Force

# Find cmd folder and add to PATH (session + user)
$gitCmd = Join-Path $outDir 'cmd'
if (-not (Test-Path $gitCmd)) {
  $cmdDir = Get-ChildItem -Path $outDir -Recurse -Directory -Filter 'cmd' | Select-Object -First 1
  if ($cmdDir) { $gitCmd = $cmdDir.FullName }
}
$env:Path = "$gitCmd;$env:Path"
$userPath = [Environment]::GetEnvironmentVariable('Path','User')
if ([string]::IsNullOrEmpty($userPath)) {
  [Environment]::SetEnvironmentVariable('Path', "$gitCmd", 'User')
} elseif ($userPath -notlike "*$gitCmd*") {
  [Environment]::SetEnvironmentVariable('Path', "$gitCmd;$userPath", 'User')
}

# Verify
& "$gitCmd\git.exe" --version
```

### Basic Git Setup
```powershell
# Repo-local identity (what we used for the initial commit)
git config user.name "$env:USERNAME"
git config user.email "$env:USERNAME@localhost"

# Optional: set defaults globally for all repos
git config --global user.name "Your Name"
git config --global user.email "you@company.com"

# Recommended on Windows
git config --global core.autocrlf true

# Optional: default branch name
git config --global init.defaultBranch main
```

### Initialize and Commit (what we executed)
```powershell
git init
git add -A
git commit -m "Initial commit"
# Optional: rename the default branch
# git branch -m main
```

### Git Bash in VS Code (PortableGit)
- Confirm path exists: `%USERPROFILE%\Apps\Git\PortableGit\bin\bash.exe`.
- VS Code workspace profile (already set in `.vscode/settings.json` and `data-science.code-workspace`):
  - Default profile: `Git Bash (PortableGit)` -> `${env:USERPROFILE}\Apps\Git\PortableGit\bin\bash.exe` with args `--login -i`.
- Use it: close terminals → `Terminal -> New Terminal` (should open Git Bash). If it doesn’t, open Command Palette → `Terminal: Select Default Profile` → pick `Git Bash (PortableGit)`.
- Manual one-off launch from PowerShell:
```powershell
& "$env:USERPROFILE\Apps\Git\PortableGit\bin\bash.exe" --login -i
```

## Poetry Environment

This project uses Poetry (see `pyproject.toml`). Python constraint is `>=3.14,<3.15`. If your machine doesn’t have that version, either:
- point Poetry at a suitable Python with `poetry env use <path-to-python.exe>`, or
- adjust the `python =` version in `pyproject.toml` to match an installed version.

Common workflow:
```powershell
# In the project root
poetry --version                  # verify Poetry is available
poetry env use <path-to-python>   # optional: select a specific Python
poetry install                    # create venv and install dependencies

# Activate shell (optional) or prefix with `poetry run`
poetry shell
```

If Poetry is not installed and you still have no admin rights, use a user-space install (one option):
```powershell
# Requires Python available on PATH (no admin)
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
(Invoke-WebRequest -UseBasicParsing https://install.python-poetry.org).Content | python -
# Add Poetry to PATH for current session (adjust the path if output differs)
$env:Path = "$env:APPDATA\Python\Scripts;$env:LOCALAPPDATA\pypoetry\Cache\venv\Scripts;$env:Path"
poetry --version
```

## Jupyter & Kernel Setup

Dependencies in `pyproject.toml` already include `jupyterlab` and `ipykernel`. After `poetry install`:
```powershell
# Register the project venv as a Jupyter kernel
poetry run python -m ipykernel install --user --name data-science --display-name "Python (data-science)"

# Launch Jupyter Lab (uses project environment)
poetry run jupyter lab
```

### nbconvert (HTML export)
To export a notebook to HTML without inputs, run from the project root:
```powershell
poetry run jupyter nbconvert --to html --no-input actuarial-inventory2.ipynb --output actuarial-inventory2-presentation.html
```
If this fails, ensure Jupyter is installed in the Poetry venv (`poetry run python -c "import jupyter"`) and that you’re using the project’s kernel.

## Optional: GitHub CLI (No‑Admin)

Install `gh` user‑local (helpful for `gh auth login`, `gh repo create`, etc.):
```powershell
New-Item -ItemType Directory -Path "$env:USERPROFILE\Apps\GitHubCLI" -Force | Out-Null
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$rel = Invoke-RestMethod https://api.github.com/repos/cli/cli/releases/latest
$asset = $rel.assets | Where-Object { $_.name -like 'gh_*_windows_amd64.zip' } | Select-Object -First 1
Invoke-WebRequest -Uri $asset.browser_download_url -OutFile "$env:TEMP\gh.zip"
Expand-Archive -Path "$env:TEMP\gh.zip" -DestinationPath "$env:USERPROFILE\Apps\GitHubCLI" -Force

$ghCmd = (Get-ChildItem "$env:USERPROFILE\Apps\GitHubCLI" -Recurse -Filter gh.exe | Select-Object -First 1).Directory.FullName
$env:Path = "$ghCmd;$env:Path"
$old = [Environment]::GetEnvironmentVariable('Path','User')
if ($old -notlike "*$ghCmd*") { [Environment]::SetEnvironmentVariable('Path', "$ghCmd;$old", 'User') }

gh --version
```
Then authenticate:
```powershell
gh auth login
# Choose GitHub.com, HTTPS, and login via browser
```

## Troubleshooting Notes
- Corporate environments may block script downloads; if API calls fail, try downloading assets via a browser and extracting manually to the same folders.
- If a new terminal doesn’t see `git`/`gh`, sign out/in or open a fresh terminal so the updated user PATH is picked up.
- If `poetry install` complains about Python version, either install a matching Python or relax the version in `pyproject.toml`.

---
Created: 2025‑12‑16