# Metadata Master Sheet v2 2026 - Generated Successfully

## File Created
**`Metadata_Master_Sheet_v2_2026.xlsx`**

## Structure

The Excel file contains **7 tabs** as specified:

### 1. **Sources** (SOR Inventory – Raw Focus)
- 12 columns matching specification
- 2 example rows (Duck Creek Clarity, Guidewire)
- Primary tab for SMEs to fill

### 2. **Targets** (Bronze / Silver Placeholders)
- 9 columns for source-to-target mapping
- 2 example mappings
- Includes bronze table names, schemas, append-only flags

### 3. **Pipelines** (High-Level Definitions)
- 9 columns for pipeline definitions
- 2 example pipelines
- Links sources to targets with patterns and status

### 4. **Gaps & Actions**
- 9 columns for gap tracking
- 4 example gaps (covering key areas from plan)
- Centralized tracker with owners and deadlines

### 5. **Glossary** (Seeded from MVM)
- 5 columns for term definitions
- 4 example terms (PolicyGUID, Premium, CDC, Bronze Layer)
- Foundation for AI-ready KG

### 6. **Gap Analysis** (Current vs Future State)
- 9 columns for executive summary
- 4 example gaps matching the plan document
- Strategic vs Tactical breakdown

### 7. **Triples Analysis** (The Core Gap)
- 7 columns matching specification exactly
- 2 example pipelines (Duck Creek API, Guidewire CDC)
- Maps the "Triples Problem" flows

## Formatting Applied

✅ **Header Row Formatting:**
- Blue background (#366092)
- White bold text
- Centered alignment
- Borders applied

✅ **Data Cell Formatting:**
- Borders on all cells
- Text wrapping enabled
- Top alignment for readability

✅ **Conditional Formatting:**
- Status column: Color-coded (Red=Open, Yellow=In Progress, Green=Closed)
- Priority column: Color-coded (Red=High, Yellow=Medium, Green=Low)
- Type column: Color-coded (Gray=Tactical, Blue=Strategic)

✅ **Usability Features:**
- Column widths auto-adjusted (capped at 50 characters)
- Header row frozen for scrolling
- All 7 tabs properly formatted

## Example Data Included

The file includes example rows for:
- **Duck Creek Clarity** (API/Batch pattern, requires iPaaS)
- **Guidewire** (CDC pattern, direct to lakehouse)

This demonstrates both flow patterns:
- Flow #2 (Via iPaaS) - Duck Creek example
- Flow #1 (Direct) - Guidewire example

## Next Steps

1. **Fill with Real Data:**
   - Replace example rows with actual SOR data
   - Add all source tables (aim for 8-15 per SOR)
   - Populate triples analysis for all pipelines

2. **Delegate to SMEs:**
   - Share Sources tab for filling
   - Use during 20-30 min calls
   - Track completion via Filled_By_Date column

3. **Use with Notebook:**
   - Load in `ingestion-impact-plan.ipynb`
   - Set `USE_V2 = True` to enable triples analysis
   - Generate visualizations and gap reports

4. **Version Control:**
   - Save dated copies as you fill: `v2_2026-02-07_filled.xlsx`
   - Track progress over time

## Column Name Compatibility

The file uses the **specification format** for column names:
- `SOR_Pipeline` (not `SOR/Pipeline`)
- `Flow_1_Direct_to_SoR_Lakehouse` (not `Flow #1: Direct to SoR/Lakehouse?`)

The notebook is configured to handle both formats automatically, so you can use either naming convention.

## Generation Script

The file was generated using `generate_master_sheet.py`. You can:
- Modify the script to add more example rows
- Adjust formatting colors/styles
- Add additional validation or formulas
- Regenerate as needed

---

**Ready for kickoff delegation!** 🚀

