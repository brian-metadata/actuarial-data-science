# Quick Start Guide - Data Science Environment

**Complete setup: ~20 minutes | No admin required**

---

## Installation (5 steps)

### 1️⃣ Git Bash (includes Git)
- Download: https://git-scm.com/download/win
- Install with defaults
- Verify: `git --version`

### 2️⃣ Python 3.14+
- Download: https://www.python.org/downloads/
- **Check: "Add Python to PATH"**
- Verify: `python --version`

### 3️⃣ Poetry
In Git Bash:
```bash
curl -sSL https://install.python-poetry.org | python -
echo 'export PATH="$HOME/AppData/Roaming/Python/Scripts:$PATH"' >> ~/.bashrc
source ~/.bashrc
poetry --version
```

### 4️⃣ VS Code
- Download: https://code.visualstudio.com/
- Install with defaults
- Install extensions:
  - **Python** (ms-python.python)
  - **Pylance** (ms-python.vscode-pylance)
  - **Jupyter** (ms-toolsai.jupyter)

### 5️⃣ Scoop (optional, for extra tools)
In Git Bash:
```bash
powershell -NoProfile -Command "iwr -useb get.scoop.sh | iex"
echo 'export PATH="$HOME/scoop/shims:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

---

## Create Your First Project (3 steps)

```bash
# 1. Create project directory
mkdir -p ~/code/data-science
cd ~/code/data-science
git init

# 2. Initialize with Poetry
poetry init -n --name "data-science"
poetry config virtualenvs.in-project true

# 3. Add packages
poetry add numpy pandas matplotlib seaborn scikit-learn jupyter jupyterlab ipykernel
poetry add --group dev pytest black ruff mypy
poetry install

# 4. Register Jupyter kernel
poetry run python -m ipykernel install --user --name data-science --display-name "Python (data-science)"

# 5. Create structure
mkdir -p notebooks data/{raw,processed} src tests models

# 6. Launch Jupyter
poetry run jupyter lab
```

**Result:** Jupyter opens in browser → Create notebook → Select "Python (data-science)" kernel → Start coding!

---

## VS Code Setup (1 minute)

1. Open VS Code
2. `Ctrl + ,` → Search: `terminal.integrated.defaultProfile.windows` → Set to: `Git Bash`
3. Done! Bash terminal now default

---

## Daily Workflow

```bash
cd ~/code/data-science

# Start
poetry shell                    # Activate environment
poetry run jupyter lab          # Launch Jupyter

# Work on notebooks and code

# End of day
git add -A
git commit -m "Your message"
exit                            # Exit poetry shell
```

---

## Essential Commands

### Poetry
```bash
poetry add package-name         # Add package
poetry install                  # Install all
poetry run jupyter lab          # Run Jupyter
poetry show                     # List packages
poetry update                   # Update all
```

### Jupyter
- `Shift + Enter` - Run cell
- `Ctrl + /` - Comment
- Export: `poetry run jupyter nbconvert --to html notebook.ipynb`

### Git
```bash
git add -A                      # Stage all
git commit -m "message"         # Commit
git log --oneline               # View history
```

### VS Code Shortcuts
| Shortcut | Action |
|----------|--------|
| `Ctrl + Shift + P` | Command Palette |
| `Ctrl + `` | Terminal |
| `Ctrl + F` | Find |
| `F5` | Debug |
| `Ctrl + ,` | Settings |

---

## Common Issues

**Poetry not found?**
```bash
source ~/.bashrc
```

**Kernel not available?**
```bash
poetry run python -m ipykernel install --user --name data-science --force
```

**Wrong terminal in VS Code?**
- `Ctrl + ,` → Search `terminal.integrated.defaultProfile.windows` → Set `Git Bash`

---

## Next: Read Full Guide

See `SETUP.md` for complete documentation covering:
- ✅ All installation options (Bash & PowerShell)
- ✅ Advanced VS Code configuration
- ✅ Python/Data Science environment details
- ✅ Project scaffolding templates
- ✅ Troubleshooting
- ✅ Docker & WSL 2 setup (when admin approved)

---

## Get Help

- **Python:** https://docs.python.org/
- **Poetry:** https://python-poetry.org/docs/
- **Jupyter:** https://jupyter.org/
- **Git Bash:** https://git-scm.com/
- **VS Code:** https://code.visualstudio.com/docs

---

**Setup Time:** ~20 minutes  
**Result:** Complete Python + Data Science environment ready for work! 🚀
