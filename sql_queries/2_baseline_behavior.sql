-- CTE: Calculate the average behaviors for both groups
WITH CustomerAverages AS (
    SELECT
        Attrition_Flag,
        ROUND(AVG(Total_Trans_Amt), 2) AS avg_transaction_amount,
        ROUND(AVG(Total_Trans_CT), 1) AS avg_transaction_count,
        ROUND(AVG(Total_Revolving_Bal), 2) AS avg_revolving_balance,
        ROUND(AVG(Contacts_Count_12_mon), 1) AS avg_service_calls
    FROM `nova_bank_churn.cleaned_customer_data`
    GROUP BY Attrition_Flag
)

-- Main Query: Calculate the percentage difference using cross joins
SELECT
    Existing.avg_transaction_amount AS existing_spend,
    Attrited.avg_transaction_amount AS attrited_spend,
    ROUND(((Attrited.avg_transaction_amount - Existing.avg_transaction_amount) / Existing.avg_transaction_amount) *100, 2) AS spend_difference_pct,

    Existing.avg_transaction_count AS existing_trans_count,
    Attrited.avg_transaction_count AS attrited_trans_count,
    ROUND(((Attrited.avg_transaction_count - Existing.avg_transaction_count) / Existing.avg_transaction_count) * 100, 2) AS trans_count_difference_pct,

    Existing.avg_revolving_balance AS existing_balance,
    Attrited.avg_revolving_balance AS attrited_balance,
    ROUND(((Attrited.avg_revolving_balance - Existing.avg_revolving_balance) / Existing.avg_revolving_balance) * 100, 2) AS balance_difference_pct

FROM CustomerAverages AS Existing
CROSS JOIN CustomerAverages AS Attrited
WHERE Existing.Attrition_Flag = 'Existing Customer'
  AND Attrited.Attrition_Flag = 'Attrited Customer';
