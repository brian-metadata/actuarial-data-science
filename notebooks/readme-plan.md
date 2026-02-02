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
This is fact-based and data-driven. We validate what’s already working (e.g., direct patterns) while clearly showing vital gaps that must close for a proper foundation. Tactical MVM progress feeds strategic KG vision. With your support on DD access and SME accountability, we deliver modernization without recreating the hairball.




