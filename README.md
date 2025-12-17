
# Data Science Environment Setup with Poetry & JupyterLab

This README documents two approaches for setting up a Python-based data science environment on Windows using Poetry and JupyterLab:

- PowerShell Bootstrap Script – Automates the setup.
- Manual Commands (cmd / Windows Terminal) – For step-by-step configuration.

## ✅ 1. PowerShell Bootstrap Script

Run the script:

```powershell
# Allow script execution for this session
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

# Run the bootstrap script
./data-science-bootstrap.ps1
```

### Script Content:

```powershell
<# Bootstrap a Poetry-based data science environment on Windows #>

# Install Poetry
$installerUrl = 'https://install.python-poetry.org'
$installerFile = Join-Path $env:TEMP ("install-poetry-{0}.py" -f ([System.Guid]::NewGuid()))
Invoke-WebRequest -Uri $installerUrl -OutFile $installerFile
& py $installerFile

# Locate poetry.exe
$poetry = "$env:APPDATA\pypoetry\venv\Scripts\poetry.exe"

# Create project folder
$proj = "C:\\Users\\bbrewer1\\data-science"
New-Item -ItemType Directory -Force -Path $proj | Out-Null
Set-Location $proj

# Initialize Poetry project
& $poetry init --name "data-science" --description "Poetry-based data science environment" --license "Proprietary" --no-interaction
& $poetry config virtualenvs.in-project true
& $poetry env use 3.14

# Add dependencies
& $poetry add numpy pandas matplotlib seaborn scikit-learn jupyterlab ipykernel

# Register Jupyter kernel
& $poetry run python -m ipykernel install --user --name data-science-py314 --display-name "data-science (Python 3.14)"

# Launch JupyterLab
& $poetry run jupyter lab
```

## ✅ 2. Manual Setup (cmd / Windows Terminal)

If you already created `pyproject.toml` in `C:\Users\bbrewer1\data-science`, run:

```cmd
cd C:\Users\bbrewer1\data-science

:: Ensure Poetry uses local virtualenv
poetry config virtualenvs.in-project true

:: Create virtual environment with Python 3.14
poetry env use 3.14

:: Install dependencies from pyproject.toml
poetry install

:: Register Jupyter kernel
poetry run python -m ipykernel install --user --name data-science-py314 --display-name "data-science (Python 3.14)"

:: Launch JupyterLab
poetry run jupyter lab
```

## ✅ Example pyproject.toml

```toml
[tool.poetry]
name = "data-science"
version = "0.1.0"
description = "Poetry-based data science environment"
authors = ["Brian Brewer <bbrewer1@example.com>"]

[tool.poetry.dependencies]
python = ">=3.14,<3.15"
numpy = "*"
pandas = "*"
matplotlib = "*"
seaborn = "*"
scikit-learn = "*"
jupyterlab = "*"
ipykernel = "*"

[build-system]
requires = ["poetry-core>=2.0.0,<3.0.0"]
build-backend = "poetry.core.masonry.api"
```

## ✅ Verify Installation

```bash
poetry run python -c "import sys; print(sys.version)"
poetry run pip list
```

## Optional Extras

Add more packages later:

```bash
poetry add scipy statsmodels plotly
poetry add --group dev black ruff
```

**Tip:** To install JupyterLab extensions, you may need Node.js:

```bash



