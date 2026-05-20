# Data Science Environment

A Poetry-based data science environment for Windows with support for multiple projects.

## 🚀 Quick Start

**New to this project?** Start here: **[docs/START_HERE.md](docs/START_HERE.md)**

**Need a quick reference?** See: **[docs/QUICK_START.md](docs/QUICK_START.md)**

## 📁 Project Structure

```
data-science/
├── actuarial-inventory/          # Actuarial inventory analysis project
├── lakehouse-gap-analysis/       # Lakehouse ingestion gap analysis project
├── docs/                         # Documentation
│   ├── START_HERE.md            # Complete setup guide
│   ├── QUICK_START.md           # Quick reference
│   ├── SETUP.md                 # Comprehensive setup guide
│   ├── bash-setup.md            # Git Bash setup
│   ├── configuration.md         # Configuration guide
│   └── DOCUMENTATION_INDEX.md   # Documentation index
├── pyproject.toml                # Poetry dependencies
└── README.md                     # This file
```

## 📚 Documentation

All documentation is in the `docs/` folder:

- **[START_HERE.md](docs/START_HERE.md)** - Complete setup guide (start here!)
- **[QUICK_START.md](docs/QUICK_START.md)** - Quick reference guide
- **[SETUP.md](docs/SETUP.md)** - Comprehensive setup documentation
- **[DOCUMENTATION_INDEX.md](docs/DOCUMENTATION_INDEX.md)** - Full documentation index

## ⚡ Quick Setup

This project uses Poetry for dependency management. To get started:

```bash
# Install dependencies
poetry install

# Register Jupyter kernel
poetry run python -m ipykernel install --user --name data-science --display-name "Python (Poetry - data-science)"

# Launch Jupyter Lab
poetry run jupyter lab
```

## 🔧 Dependencies

See `pyproject.toml` for the complete list. Key packages include:
- **Data Science**: numpy, pandas, matplotlib, seaborn, scikit-learn
- **Notebooks**: jupyterlab, ipykernel
- **Visualization**: networkx (for graph analysis)
- **Excel**: openpyxl (for Excel file generation)

## 📝 Projects

### Actuarial Inventory
Location: `actuarial-inventory/`
- Actuarial inventory analysis notebooks
- Charts and outputs
- Context engineering materials

### Lakehouse Gap Analysis
Location: `lakehouse-gap-analysis/notebooks/`
- Ingestion impact plan analysis
- Metadata master sheet
- Gap analysis and triples mapping

## 🛠️ Development

This environment uses:
- **Poetry** for dependency management
- **Python 3.14** (via Poetry)
- **Jupyter Lab** for interactive notebooks
- **VS Code** workspace configuration included

For detailed setup instructions, see the [documentation](docs/).
