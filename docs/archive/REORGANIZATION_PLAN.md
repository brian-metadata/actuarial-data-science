# Project Reorganization Plan

## Overview
This reorganization will separate the actuarial-inventory project from the lakehouse-gap-analysis project into distinct folders.

## Proposed Structure

```
data-science/
├── actuarial-inventory/          # All actuarial inventory files
│   ├── actuarial_impact_analysis.ipynb
│   ├── Actuarial-Inventory.ipynb
│   ├── actuarial-inventory2.ipynb
│   ├── actuarial-inventory2.*.html
│   ├── actuarial-inventory2.pdf
│   ├── Exec_KPI.ipynb
│   ├── ACTUARIAL_INVENTORY_SUMMARY.md
│   ├── Actuarial_Inventory_Overview_Slide1.ipynb_generated.pptx
│   ├── flowchart TB.mmd
│   ├── charts/                    # Actuarial charts
│   ├── output/                    # Actuarial outputs
│   ├── context-engineering/       # Actuarial context
│   └── presentation-planning/     # Actuarial presentations
│
├── lakehouse-gap-analysis/        # All lakehouse gap analysis files
│   └── notebooks/
│       ├── ingestion-impact-plan.ipynb
│       ├── readme-plan.md
│       ├── Metadata_Master_Sheet_v2_2026.xlsx
│       ├── generate_master_sheet.py
│       ├── update_notebook_cell.py
│       ├── EXCEL_FILE_GENERATED.md
│       └── NOTEBOOK_IMPROVEMENTS.md
│
└── (root - shared files)
    ├── pyproject.toml              # Poetry config (shared)
    ├── poetry.lock                 # Poetry lock (shared)
    ├── .venv/                      # Poetry virtual environment (shared)
    ├── data-science.code-workspace # VS Code workspace
    ├── README.md
    ├── SETUP.md
    ├── QUICK_START.md
    ├── START_HERE.md
    ├── ADMIN_REQUEST.md
    ├── bash-setup.md
    ├── configuration.md
    ├── DOCUMENTATION_INDEX.md
    ├── assets/                     # Shared assets
    └── bootstrap-scaffold/        # Setup scripts
```

## Safety Checks

✅ **No Cross-References Found**
- Lakehouse files don't reference actuarial files
- Actuarial files don't reference lakehouse files
- Both projects are independent

✅ **Path Compatibility**
- Notebook uses relative paths (`os.path.exists()`)
- Excel file will be in same directory as notebook after move
- All paths will remain valid

✅ **Shared Resources**
- `pyproject.toml` and `poetry.lock` stay at root (shared)
- `.venv` stays at root (shared)
- Workspace config stays at root

## Files to Move

### Actuarial Inventory (→ `actuarial-inventory/`)
- `actuarial_impact_analysis.ipynb`
- `Actuarial-Inventory.ipynb`
- `actuarial-inventory2.ipynb`
- `actuarial-inventory2-*.html` (4 files)
- `actuarial-inventory2.pdf`
- `Exec_KPI.ipynb`
- `ACTUARIAL_INVENTORY_SUMMARY.md`
- `Actuarial_Inventory_Overview_Slide1.ipynb_generated.pptx`
- `flowchart TB.mmd`
- `charts/` folder
- `output/` folder
- `context-engineering/` folder
- `presentation-planning/` folder
- `actuarial-inventory/` folder (if it exists)

### Lakehouse Gap Analysis (→ `lakehouse-gap-analysis/notebooks/`)
- `notebooks/ingestion-impact-plan.ipynb`
- `notebooks/readme-plan.md`
- `notebooks/Metadata_Master_Sheet_v2_2026.xlsx`
- `notebooks/generate_master_sheet.py`
- `notebooks/update_notebook_cell.py`
- `notebooks/EXCEL_FILE_GENERATED.md`
- `notebooks/NOTEBOOK_IMPROVEMENTS.md`

## Execution

The script `reorganize_project.ps1` will:
1. Create the new folder structure
2. Move files safely with error handling
3. Clean up temporary files
4. Report what was moved

## After Reorganization

1. **Update workspace** (if needed):
   - The `data-science.code-workspace` should still work
   - You may want to add both folders to the workspace

2. **Test notebooks**:
   - Run `lakehouse-gap-analysis/notebooks/ingestion-impact-plan.ipynb` to verify Excel file loads
   - Verify actuarial notebooks still work

3. **Update documentation** (optional):
   - Update README.md to reflect new structure
   - Update any path references in documentation

## Rollback Plan

If something goes wrong:
- All files are moved (not copied), so they're still in the repo
- You can manually move them back
- Git will track all changes if you commit after reorganization

---

**Ready to execute?** Run: `.\reorganize_project.ps1`

