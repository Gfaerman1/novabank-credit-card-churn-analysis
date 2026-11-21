
-- BASELINE BEHAVIORAL ANALYSIS
-- Purpose: Compare average transaction activity and revolving balances
-- between existing and attrited customers.
-- CTE: Calculate full-precision averages for both customer groups

WITH CustomerAverages AS (

    SELECT
        Attrition_Flag,

        AVG(Total_Trans_Amt) AS avg_transaction_amount,
        AVG(Total_Trans_CT) AS avg_transaction_count,
        AVG(Total_Revolving_Bal) AS avg_revolving_balance

    FROM `nova_bank_churn.cleaned_customer_data`

    GROUP BY Attrition_Flag
)

-- Main Query: Compare the averages and calculate percentage differences

SELECT

    -- Transaction amount comparison
    ROUND(Existing.avg_transaction_amount, 2) AS existing_spend,
    ROUND(Attrited.avg_transaction_amount, 2) AS attrited_spend,

    ROUND(
        SAFE_DIVIDE(
            Attrited.avg_transaction_amount - Existing.avg_transaction_amount, Existing.avg_transaction_amount) * 100, 2) AS spend_difference_pct,

    -- Transaction count comparison
    ROUND(Existing.avg_transaction_count, 1) AS existing_trans_count,
    ROUND(Attrited.avg_transaction_count, 1) AS attrited_trans_count,
    ROUND(SAFE_DIVIDE(Attrited.avg_transaction_count - Existing.avg_transaction_count, Existing.avg_transaction_count) * 100, 2) AS trans_count_difference_pct,

    -- Revolving balance comparison
    ROUND(Existing.avg_revolving_balance, 2) AS existing_balance,
    ROUND(Attrited.avg_revolving_balance, 2) AS attrited_balance,

    ROUND(
        SAFE_DIVIDE(
            Attrited.avg_revolving_balance - Existing.avg_revolving_balance,
            Existing.avg_revolving_balance) * 100, 2) AS balance_difference_pct

FROM CustomerAverages AS Existing

CROSS JOIN CustomerAverages AS Attrited

WHERE Existing.Attrition_Flag = 'Existing Customer'
  AND Attrited.Attrition_Flag = 'Attrited Customer';
