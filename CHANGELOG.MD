### Data Processing Changelog
**Date:** November 2026
**Tool Used:** Google BigQuery (SQL)

* **[Added]** Uploaded raw Kaggle CSV (`BankChurners.csv`) to BigQuery workspace `nov_abank_churn.bank_churners`.
* **[Verified]** Checked data types; confirmed financial columns (`Credit_Limit`, `Total_Trans_Amt`) were correctly assigned as numeric/float values.
* **[Verified]** Scanned for null values across all critical demographic and financial fields. No nulls detected.
* **[Removed]** Executed a `SELECT EXCEPT` query to drop `CLIENTNUM` to maintain customer anonymization.
* **[Removed]** Dropped external machine learning columns (`Naive_Bayes_Classifier_...`) as they were not part of the raw historical dataset.
* **[Cleaned]** Applied `DISTINCT` command to ensure zero duplicate records transferred to the working table.
* **[Saved]** Created new clean working table: `nova_bank_churn.cleaned_customer_data` (10,127 rows).