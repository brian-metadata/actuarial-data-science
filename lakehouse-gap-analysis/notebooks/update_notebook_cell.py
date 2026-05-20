"""Update the data loading cell in the notebook"""
import json

# Read the notebook
with open('ingestion-impact-plan.ipynb', 'r', encoding='utf-8') as f:
    nb = json.load(f)

# New cell source
new_source = [
    "# Load master sheet (replace path if needed)\n",
    "import os\n",
    "\n",
    "if USE_V2:\n",
    "    # Try new file name first, then fall back to old name for compatibility\n",
    "    if os.path.exists('Metadata_Master_Sheet_v2_2026.xlsx'):\n",
    "        master_file = 'Metadata_Master_Sheet_v2_2026.xlsx'\n",
    "    elif os.path.exists('Metadata_Master_Sheet_Template_v2.xlsx'):\n",
    "        master_file = 'Metadata_Master_Sheet_Template_v2.xlsx'\n",
    "    else:\n",
    "        master_file = 'Metadata_Master_Sheet_v2_2026.xlsx'  # Default to new name\n",
    "else:\n",
    "    # Try new file name first, then fall back to old name\n",
    "    if os.path.exists('Metadata_Master_Sheet_v2_2026.xlsx'):\n",
    "        master_file = 'Metadata_Master_Sheet_v2_2026.xlsx'\n",
    "    elif os.path.exists('Metadata_Master_Sheet_Template.xlsx'):\n",
    "        master_file = 'Metadata_Master_Sheet_Template.xlsx'\n",
    "    else:\n",
    "        master_file = 'Metadata_Master_Sheet_v2_2026.xlsx'  # Default to new name\n",
    "\n",
    "print(f\"Loading data from: {master_file}\")\n",
    "\n",
    "try:\n",
    "    # Load all 7 tabs per specification\n",
    "    sources = pd.read_excel(master_file, sheet_name='Sources')\n",
    "    targets = pd.read_excel(master_file, sheet_name='Targets')\n",
    "    pipelines = pd.read_excel(master_file, sheet_name='Pipelines')\n",
    "    gaps = pd.read_excel(master_file, sheet_name='Gaps & Actions')\n",
    "    glossary = pd.read_excel(master_file, sheet_name='Glossary')\n",
    "    gap_analysis = pd.read_excel(master_file, sheet_name='Gap Analysis')\n",
    "    \n",
    "    # Load triples if using v2\n",
    "    if USE_V2:\n",
    "        triples = pd.read_excel(master_file, sheet_name='Triples Analysis')\n",
    "        print(\"Triples Analysis loaded\")\n",
    "    else:\n",
    "        triples = None\n",
    "    \n",
    "    print(\"All data sheets loaded successfully\")\n",
    "    print(f\"  - Sources: {len(sources)} rows\")\n",
    "    print(f\"  - Targets: {len(targets)} rows\")\n",
    "    print(f\"  - Pipelines: {len(pipelines)} rows\")\n",
    "    print(f\"  - Gaps: {len(gaps)} rows\")\n",
    "    print(f\"  - Glossary: {len(glossary)} rows\")\n",
    "    print(f\"  - Gap Analysis: {len(gap_analysis)} rows\")\n",
    "    if triples is not None:\n",
    "        print(f\"  - Triples: {len(triples)} rows\")\n",
    "    \n",
    "    # Basic validation: Check for required columns\n",
    "    required_sources_cols = ['SOR_Name', 'Source_Table_or_View_Name', 'Ingestion_Pattern']\n",
    "    missing_cols = [col for col in required_sources_cols if col not in sources.columns]\n",
    "    if missing_cols:\n",
    "        print(f\"Warning: Missing columns in Sources: {missing_cols}\")\n",
    "    else:\n",
    "        print(\"Sources tab structure validated\")\n",
    "        \n",
    "except FileNotFoundError:\n",
    "    print(f\"Error: File '{master_file}' not found.\")\n",
    "    print(f\"Current directory: {os.getcwd()}\")\n",
    "    print(\"Available Excel files:\")\n",
    "    excel_files = [f for f in os.listdir('.') if f.endswith('.xlsx')]\n",
    "    if excel_files:\n",
    "        for f in excel_files:\n",
    "            print(f\"  - {f}\")\n",
    "    else:\n",
    "        print(\"  (no Excel files found)\")\n",
    "    print(\"\\nPlease ensure the Excel file is in the same directory as this notebook.\")\n",
    "    print(\"Or update the master_file path in the cell above.\")\n",
    "    raise\n",
    "except Exception as e:\n",
    "    print(f\"Error loading data: {e}\")\n",
    "    raise\n"
]

# Update cell 3 (index 3)
nb['cells'][3]['source'] = new_source

# Write back
with open('ingestion-impact-plan.ipynb', 'w', encoding='utf-8') as f:
    json.dump(nb, f, indent=2, ensure_ascii=False)

print("Notebook cell 3 updated successfully!")

