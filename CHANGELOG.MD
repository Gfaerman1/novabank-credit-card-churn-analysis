### Data Processing & Validation Changelog

**Date:** November 2026  
**Tool Used:** Google BigQuery (SQL)

**1. Initial Assessment & Customer Validation**

- **Starting Row Count:** 10,127 records.
- **Customer Uniqueness:** Validated `CLIENTNUM` by counting distinct customer IDs and grouping IDs to identify duplicates.
- **Duplicate Check:** Found 0 duplicate customer IDs, confirming that each customer ID appeared only once in the original dataset.
- **NULL ID Check:** Confirmed 0 NULL customer IDs, ensuring every source record contained a valid customer identifier.

**2. Missing & "Unknown" Data Handling**

- Scanned critical financial columns (`Credit_Limit`, `Total_Trans_Amt`) for NULL values; 0 NULLs detected.
- Investigated categorical fields for "Unknown" string values:
  - `Income_Category`: 1,112 rows
  - `Education_Level`: 1,519 rows
  - `Marital_Status`: 749 rows
- **Decision:** Retained all rows with "Unknown" demographic classifications. Removing these records could unnecessarily exclude customers with otherwise usable financial and transaction data, reducing the population available for analysis.

**3. Column Exclusions**

- **Removed `CLIENTNUM`:** Excluded the direct customer identifier from the analytical working table because it was not needed for the behavioral or demographic analysis.
- **Removed `Naive_Bayes_Classifier...` (x2):** Excluded both columns because they represent predictive machine-learning outputs rather than the original customer attributes and behavioral measurements used in this descriptive analysis.

**4. Final Verification & Record Preservation**

- **Final Row Count:** 10,127 records in `novabank_churn.cleaned_customer_data`.
- **Record Preservation:** Compared the original source table against the cleaned working table to verify that both contained the same number of records.
- **Deduplication Approach:** No `SELECT DISTINCT` operation was applied during table creation. Customer uniqueness was validated separately before cleaning, so legitimate customer records were preserved.
- **Final Result:** All 10,127 source records were retained while excluding the unnecessary identifier and machine-learning output columns.
