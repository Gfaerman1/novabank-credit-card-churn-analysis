-- DATA VALIDATION
-- Purpose: Verify that each source record represents a uniqee customer.
-- 1. Summary of source records and customer IDs
SELECT
  COUNT(*) AS total_source_records,
  COUNT(DISTINCT CLIENTNUM) AS distinct_customer_ids,
  COUNTIF(CLIENTNUM IS NULL) AS null_customer_ids,

  COUNT(*)
    - COUNTIF(CLIENTNUM IS NULL)
    - COUNT(DISTINCT CLIENTNUM) AS duplicate_id_excess_records
FROM `nova_bank_churn.bank_churners`;

-- 2. Identify any customer IDs appearing more than once
SELECT
    CLIENTNUM,
    COUNT(*) AS records_per_customer
FROM `nova_bank_churn.bank_churners`
WHERE CLIENTNUM IS NOT NULL
GROUP BY CLIENTNUM
HAVING COUNT(*) > 1
ORDER BY records_per_customer DESC;
