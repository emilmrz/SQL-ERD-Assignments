# SQL & Relational Database Design — Expanded Assignment

## Download the entire project

**[Download the complete project as one ZIP file](./SQL-ERD-Assignments-Complete.zip)** — includes the SQLite databases, all SQL exercises, both ERD projects, CSV results, and explanations. Individual files are also available in the folders below.


Complete SQLite-compatible student assignment based on the attached 23-page *Complete_SQL_ERD_Assignments_Expanded.pdf*.

## Contents
- `database/SalesDB.sqlite` — clean reference dataset, all 4 tables and 46 rows.
- `database/SalesDB_Practice.sqlite` — separate demonstration copy with safe modification tasks applied.
- `sql/database_setup.sql` — CREATE TABLE and INSERT statements for an **empty** SQLite database.
- `sql/assignments.sql` — all 68 task labels, all read-only SQL answers, and clearly marked commented practice modification answers.
- `sql/reporting_only.sql` — all read-only reports, executable without mutations.
- `sql/basic_tasks.sql` and `sql/scenario_1.sql` through `sql/scenario_6.sql` — grouped task solutions. **Scenario 2 and 3 files include data-changing statements**; execute only in a practice database, not in the clean reference file.
- `sql/modifications.sql` — all seven change-oriented tasks together. Execute on a **fresh clean copy**, in task order.
- `results/` — CSV results of read-only SQL queries.
- `erd/` — two original ERD PNG and PDF diagrams.
- `docs/EXPLANATIONS.md` — business-rule notes and requested explanatory examples.
- `docs/VALIDATION.md` — per-task execution log and row counts.

## Open in DB Browser for SQLite
1. Open `database/SalesDB.sqlite` using **Open Database**.
2. Explore the 4 tables in **Browse Data**.
3. Open `sql/reporting_only.sql` in **Execute SQL** and run it, or run individual statements from the scenario files.
4. For B10, 2.5–2.7 and 3.8–3.10, use a **new duplicate** of the clean database and `sql/modifications.sql`. Do not rerun these INSERT/ALTER statements on an already modified practice database.
5. SQLite uses `julianday()` for date differences, `||` for name concatenation, and `LIMIT` for top-N results.

## Important report conventions
A qualifying sale for Scenarios 4 and 6 is Shipped or Delivered, has a non-NULL ShipDate not earlier than OrderDate, and belongs to the given period by OrderDate. The October range ends October 31, 2026; November snapshot is November 1–7, 2026. Scenario 5 audits all operational orders as of November 7 including deliberately inconsistent data. Stored `Sales` is already the entire order amount.

## Verification
All 68 numbered tasks were executed against the respective clean or practice SQLite databases. See `docs/VALIDATION.md` and the CSV exports. `PRAGMA foreign_key_check` returned no violations for both databases.

## GitHub upload
The repository is intended to be public. The root ZIP is a convenience download; the individual folders remain available for browsing. Publication status is confirmed separately.
