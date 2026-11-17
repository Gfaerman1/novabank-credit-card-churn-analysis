### Data Processing & Validation Changelog
**Date:** November 2026
**Tool Used:** Google BigQuery (SQL)

**1. Initial Assessment**
* **Starting Row Count:** 10,127 records.
* **Customer Uniqueness:** Validated by grouping `CLIENTNUM` to check for duplicates. Found 0 duplicate customer IDs, confirming every row represents a distinct, unique customer.

**2. Missing & "Unknown" Data Handling**
* Scanned critical financial columns (`Credit_Limit`, `Total_Trans_Amt`) for NULL values; 0 NULLs detected.
* Investigated categorical fields for "Unknown" string values:
  * `Income_Category`: 1,112 rows
  * `Education_Level`: 1,519 rows
  * `Marital_Status`: 749 rows
* **Decision:** Retained all rows with "Unknown" demographics. Dropping these records would delete up to 15% of the dataset, unnecessarily sacrificing highly valuable and fully populated financial transaction data.

**3. Column Exclusions**
* **Removed `CLIENTNUM`:** Dropped to ensure strict customer anonymization.
* **Removed `Naive_Bayes_Classifier...` (x2):** Dropped both columns. These represent predictive machine-learning outputs appended to the CSV by a previous user, rather than the raw historical banking data required for this behavioral analysis.

**4. Final Verification**
* **Final Row Count:** 10,127 records transferred to `novabank_churn.cleaned_customer_data`.
* **Deduplication:** Applied `SELECT DISTINCT` during the table creation as a final integrity measure. 0 records were removed, aligning perfectly with the prior customer uniqueness check.
