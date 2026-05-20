# Lakehouse Ingestion Modernization Plan – Principal Architect Brian 
**Date:** February 02, 2026  
**Objective:** Unwind on-prem ODS hairball → direct SOR-to-lakehouse ingestion (medallion: raw bronze append-only focus).  
**Vision:** Tactical MVM (Minimum Viable Metadata) foundation for raw ingestion pipelines → strategic AI-ready enterprise Knowledge Graph (KG) with glossaries, lineage, and change governance.  
**Audience for Show-and-Tell:** Directors & CIO – fact-based, data-driven, crystal clear validation of working elements + vital gaps closing.

## 1. Scope & Key Systems (Confirmed Feb 2026)
**Primary Systems (Phase 1 – Must Close Gaps First)**
- Duck Creek / Clarity (API/batch pulls for rate cases, curated Snowflake layer preferred)
- Guidewire (Parquet CDC files – Auto Loader compatible)

**Secondary / Smaller (Phase 2 – Defer but Double-Check)**
- ImageRight (file-based documents/images)
- External data wrangling sources (Parquet, APIs, file drops)

**iPaaS Role**
- Purely technical orchestration layer (no inherent metadata unless actively pulling SOR data)
- BU (Business Unit) owns requirements/mandates for when iPaaS is required
- Core question: Authoritative flow patterns (“Triples Problem”)

## 2. The “Triples Problem” – Clearer Statement of the Central Gap
We must determine authoritative ingestion flows between Systems of Record (SoR), iPaaS, and OLTP applications.

1. **Which pipelines should feed the System of Record / Lakehouse directly?**  
   → Structured, reliable, incremental, event-based data suited for direct landing into bronze raw layer  
   (e.g., Guidewire Parquet CDC via Auto Loader)

2. **Which pipelines must route through iPaaS before reaching the System of Record?**  
   → When middleware is required: API mediation, transformations, message-queue callbacks, XML retrieval, cross-cloud connectivity, vendor/partner constraints  
   (e.g., Duck Creek Clarity API patterns discussed in meetings)

3. **Which workloads require iPaaS → OLTP (pushing data back into operational systems)?**  
   → Operational updates, reference synchronization, master data propagation, operational triggers / event loops  
   (data-quality feedback, app-triggered actions)

**Core Question (the essence of the Triples gap)**  
If pipelines #1 and #2 already deliver all System-of-Record data into the Lakehouse,  
**why does iPaaS still need to push data back to OLTP (#3)?**  
→ Analytical lakehouse (OLAP) vs. operational OLTP systems require feedback loops for real-time app actions.

## 3. Current State vs. Future State vs. Gap Analysis

| Area                        | Current State                                      | Future State                                              | Gap Description                                      | Type          | Priority | Status (Feb 2026)     | Action Owner       |
|-----------------------------|----------------------------------------------------|-----------------------------------------------------------|------------------------------------------------------|---------------|----------|-----------------------|--------------------|
| Metadata Collection         | Messy Cognizant Excels, partial DDs, no structure | Structured MVM sheets per SOR, feeding KG                | DDs not pulled from vendor portals                   | Tactical     | High     | Open – needs closure  | SOR SMEs           |
| Glossary                    | Scattered or none; seeded minimally from MVM      | AI-ready KG with full business terms & lineage           | No centralized BA/architect glossary; mapping needed | Strategic    | Medium   | In Progress           | Cognizant / BA     |
| iPaaS Flow Mandates         | Unclear BU rules; “triples” not mapped            | Defined per-SOR authoritative flows (#1–#3)              | BU relation to iPaaS undefined; why #3?              | Tactical     | High     | Open – needs closure  | iPaaS SME / BU     |
| Veracity / Validation       | No formal forward/backward checks                 | Dual validation (source → ERwin + report lineage)        | ERwin silver models unclear; no drift process        | Strategic    | Medium   | Open                  | Modeling SME       |
| Future Change Management    | Ad-hoc; no governance for schema drift            | Quarterly reviews, alerts, Unity Catalog lineage         | No defined process for source evolutions             | Strategic    | Low      | Open                  | All SMEs           |
| Triples Problem Flows       | Unknown authoritative patterns                    | Mapped #1–#3 per pipeline; justified #3 loops            | Why OLTP feedback if SoR → lakehouse covered?        | Tactical     | High     | Open – core gap       | iPaaS / BU SMEs    |

## 4. Tactical vs Strategic Priorities

**Tactical Priorities (Foundation – Must Close in Feb–Mar 2026)**
- Complete MVM sheets per SOR (raw bronze ingestion focus)
- Pull vendor DDs from portals (Duck Creek Support, Guidewire Data Studio)
- Map Triples flows (#1 direct, #2 iPaaS mediation, #3 OLTP feedback)
- Define BU/iPaaS mandates via questionnaire
- Seed glossary from MVM “Business Meanings” column

**Strategic Priorities (Vision – Build from Tactical Base)**
- Feed MVM into AI-ready enterprise KG (GraphRAG / Neo4j prototype later)
- Full glossary with BA/architect terms (adapt IIBA BABOK / industry if internal missing)
- ERwin as gold target models (silver/gold medallion validation)
- Governance for future changes (schema drift alerts, quarterly MVM refresh)
- Lineage & veracity in Unity Catalog (post-platform)

## 5. Delegation & Execution Playbook (Feb 2026 Timeline)

**Week 1 (Feb 2–7) – Prime & Delegate**
- Send kickoff email with MVM template v2 (includes Triples tab)
- Book 20–30 min calls per SOR/iPaaS/ERwin SME
- Delegate DD pulls: Duck Creek Support Portal, Guidewire Data Studio
- Attach short questionnaires (5 Qs each) for iPaaS/BU, ERwin, veracity/change

**Week 2 (Feb 8–14) – Collect & Map**
- Fill MVM sheets live on calls (you type)
- Populate Triples Analysis tab with #1–#3 answers
- Seed Glossary tab from Business Meanings
- Clarify ERwin silver models & veracity process

**Week 3 (Feb 15–21) – Validate & Visualize**
- Run Jupyter notebook on filled Excel → generate gap charts, triples DAG
- Export HTML/PDF for directors/CIO show-and-tell
- Escalate blocked items (“No DD pull = pipeline blocked”)

**Show-and-Tell Deck Outline**
1. Vision: Raw bronze ingestion → AI-ready KG
2. Current State: Working patterns (e.g., Guidewire direct CDC)
3. Triples Problem: Clear gap statement + visualization
4. Gap Analysis Table: Tactical vs Strategic
5. MVM Master Sheet Demo: Filled rows, gaps flagged
6. Data-Driven Insights: Notebook visuals (gap counts, flow bars)
7. Ask: Support to close vital gaps (DD access, BU mandates)

## 6. Deliverables & Success Metrics
- Metadata_Master_Sheet_Template_v2.xlsx (filled for Phase 1 SORs)
- Jupyter notebook (storytelling + visuals)
- Triples flows mapped (80% coverage for key SORs)
- Glossary seeded (50+ terms from MVM)
- Gap status report: Closed/In Progress/Open with owners/deadlines
- Director/CIO presentation (HTML export from notebook)

**Core Message to Leadership**  
This is fact-based and data-driven. We validate what's already working (e.g., direct patterns) while clearly showing vital gaps that must close for a proper foundation. Tactical MVM progress feeds strategic KG vision. With your support on DD access and SME accountability, we deliver modernization without recreating the hairball.

## 7. Metadata Master Sheet Specification

The **Metadata Master Sheet** is the central Excel artifact serving as the single source of truth for wrangling metadata, delegating to SMEs, visualizing gaps, and preparing the show-and-tell for directors/CIO.

**File Name:** `Metadata_Master_Sheet_v2_2026.xlsx`

### Structure: 7 Tabs (Worksheets)

#### Tab 1: Sources (SOR Inventory – Raw Focus)
**Purpose:** Capture all relevant source tables/views/datasets from each SOR. One row per table. This is the primary tab SMEs fill.

| Column Name | Data Type / Format | Required? | Description / Guidance | Example (Duck Creek Clarity) |
|-------------|-------------------|-----------|------------------------|-------------------------------|
| SOR_Name | Text | Yes | Full system name | Duck Creek Clarity |
| Source_Table_or_View_Name | Text | Yes | Actual name as appears in DB/Clarity/reports | POLICY_CURATED |
| Database_or_Schema | Text | Yes | e.g., Clarity DB name or raw schema | CLARITY_DB.POLICY_LAYER |
| Approx_Daily_Records_or_Size | Text (e.g., "50k recs / 200 MB") | Yes | Rough volumetrics for sizing | ~50k recs / 200 MB daily |
| Ingestion_Pattern | Dropdown: CDC, Incremental, Batch, Streaming, File Drop, API Pull | Yes | Primary pattern for raw bronze ingestion | Batch Export or API |
| Key_Columns_with_Types | Text (comma-separated) | Yes | Top 5–10 fields + types | PolicyGUID:VARCHAR, EffectiveDate:DATE, Premium:DECIMAL(12,2) |
| Primary_Key_or_Unique_ID | Text | Yes | PK or unique identifier | PolicyGUID |
| Business_Meanings_Key_Terms | Text (short descriptions) | Yes | Seeds glossary – short meaning for key fields | PolicyGUID = Unique system ID; Premium = Annual amount |
| PII_or_Sensitive_Flag | Yes/No + fields | Recommended | Flag sensitive data | Yes – InsuredName, Address |
| Current_Use_Reports_or_Rate_Cases | Text | Recommended | Which reports or use cases rely on this table | Rate case exposure by state; Sales Summary |
| SME_Notes_Questions_Gaps | Text | Optional | Risks, questions, or known issues | History in separate view? Deletes? |
| Filled_By_Date | Name / Date | Yes | Who filled & when | Jane Doe – 2026-02-05 |

**Guidance:** Add rows for every important table (aim 8–15 per SOR). Use actual names from Clarity/Guidewire. Business Meanings column seeds glossary.

#### Tab 2: Targets (Bronze / Silver Placeholders)
**Purpose:** Map source tables to lakehouse targets (bronze raw focus).

| Column Name | Data Type | Required? | Description / Guidance | Example |
|-------------|-----------|-----------|------------------------|----------|
| SOR_Name | Text | Yes | Link back to Sources tab | Duck Creek Clarity |
| Source_Table_or_View | Text | Yes | From Tab 1 | POLICY_CURATED |
| Bronze_Table_Name | Text | Yes | Proposed raw append-only table | bronze_duck_creek_policy_curated |
| Bronze_Schema_Simple | Text | Recommended | Simple schema string (for append-only) | PolicyGUID:VARCHAR, EffectiveDate:DATE |
| Append_Only | Yes/No | Yes | Must be Yes for raw bronze | Yes |
| Silver_Table_Name | Text | Optional | Future silver (enriched) – defer for now | silver_duck_creek_policy_cleaned |
| Unity_Catalog_Path | Text | Optional | Placeholder for future | /catalog/bronze/duck_creek_policy |
| Gap_Flag | Yes/No | Auto | Formula: If key columns missing | No |
| Notes | Text | Optional | Any target risks | — |

#### Tab 3: Pipelines (High-Level Definitions)
**Purpose:** Tie sources to targets → one pipeline per table or group.

| Column Name | Data Type | Required? | Description / Guidance | Example |
|-------------|-----------|-----------|------------------------|----------|
| Pipeline_ID | Text | Yes | Auto or manual (e.g., DC_POLICY_CDC) | DC_CLARITY_POLICY_BATCH |
| SOR_Name | Text | Yes | — | Duck Creek Clarity |
| Source_Table | Text | Yes | — | POLICY_CURATED |
| Bronze_Table | Text | Yes | — | bronze_duck_creek_policy_curated |
| Pattern | Text | Yes | — | Batch Export |
| iPaaS_Required | Yes/No/TBD | Yes | From Triples tab | Yes (API mediation) |
| Estimated_Effort | Low/Med/High | Optional | Rough sizing | Medium |
| Risks_AntiPattern | Text | Optional | e.g., "High volume – queue?" | Partner constraints |
| Status | Planned/In Progress/Complete/Blocked | Yes | Track progress | Planned |

#### Tab 4: Gaps & Actions
**Purpose:** Centralized tracker (auto-pull from other tabs if formulas added).

**Columns:** Area, Gap Description, Type (Tactical/Strategic), Priority (High/Med/Low), Status (Open/In Progress/Closed), Action Plan, Owner, Deadline, Notes.

#### Tab 5: Glossary (Seeded from MVM)
**Purpose:** Tactical seed → strategic KG feed.

| Column Name | Data Type | Required? | Description / Guidance | Example |
|-------------|-----------|-----------|------------------------|----------|
| Term | Text | Yes | — | PolicyGUID |
| Definition | Text | Yes | From Business Meanings column | Unique system-generated policy identifier |
| Category | Text | Recommended | e.g., Field Meaning, Ingestion Pattern | Field Meaning |
| Used_In | Text | Optional | SORs/tables where it appears | Duck Creek Clarity – POLICY_CURATED |
| Source | Text | Yes | MVM sheet & row reference | Sources Tab – Row 1 |

#### Tab 6: Gap Analysis (Current vs Future State)
**Purpose:** Executive summary table (copy from plan .md or populate here).

**Columns:** Area, Current State, Future State, Gap Description, Type (Strategic/Tactical), Priority, Action Plan, Owner, Deadline.

#### Tab 7: Triples Analysis (The Core Gap)
**Purpose:** Map the "Triples Problem" flows per SOR/pipeline.

| Column Name | Data Type | Required? | Description / Guidance | Example (Duck Creek Clarity API) |
|-------------|-----------|-----------|------------------------|----------------------------------|
| SOR_Pipeline | Text | Yes | e.g., Duck Creek Clarity API for Rate Cases | Duck Creek Clarity API |
| Flow_1_Direct_to_SoR_Lakehouse | Yes/No + Pattern | Yes | Direct raw ingestion (e.g., Guidewire Parquet CDC) | No |
| Flow_2_Via_iPaaS_to_SoR | Yes/No + Reason | Yes | Mediated (API mediation, transforms, vendor constraints) | Yes (API mediation, XML retrieval) |
| Flow_3_iPaaS_to_OLTP | Yes/No + Reason | Yes | Feedback to operational apps (sync, triggers) | Yes (operational triggers for policy updates) |
| Why_Flow_3_Needed_If_1_and_2_Cover_SoR | Text | If Yes | Core justification (analytical vs operational needs) | Lakehouse is OLAP only – OLTP needs real-time sync for app actions |
| Gap_Status | Open/Closed | Yes | — | Open |
| Type | Tactical/Strategic | Yes | — | Tactical |

### Additional Notes on the Master Sheet

- **Use filters and conditional formatting** (e.g., red for Open/High priority gaps, yellow for TBD).
- **Add formulas where possible** (e.g., `Gap_Flag = IF(ISBLANK(Key_Columns), "Yes", "No")`).
- **Protect non-fillable cells** if sharing with SMEs.
- **Version control:** Save dated copies (e.g., `v2_2026-02-07_filled.xlsx`).
- **Link to notebook:** Export this Excel → load in Jupyter for visuals (gap counts, triples DAG).

This spec covers everything needed to build, delegate, fill, analyze, and present the master sheet. Ready for kickoff delegation.




