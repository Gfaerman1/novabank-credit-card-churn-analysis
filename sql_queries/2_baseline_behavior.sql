-- CTE: Calculate the average behaviors for both groups
WITH CustomerAverages AS (
    SELECT
        Attrition_Flag,
        (AVG(Total_Trans_Amt), 2) AS avg_transaction_amount,
        (AVG(Total_Trans_CT), 1) AS avg_transaction_count,
        (AVG(Total_Revolving_Bal), 2) AS avg_revolving_balance,
    FROM `nova_bank_churn.cleaned_customer_data`
    GROUP BY Attrition_Flag
)

-- Main Query: Calculate the percentage difference using cross joins
SELECT
    ROUND(Existing.avg_transaction_amount, 2) AS existing_spend,
    ROUND(Attrited.avg_transaction_amount, 2) AS attrited_spend,
    ROUND(SAFE_DIVIDE(Attrited.avg_transaction_amount - Existing.avg_transaction_amount,Existing.avg_transaction_amount) * 100, 2) AS spend_difference_pct,

    -- Revolving balance comparison
    ROUND(Existing.avg_revolving_balance, 2) AS existing_balance,
    ROUND(Attrited.avg_revolving_balance, 2) AS attrited_balance,
    ROUND(SAFE_DIVIDE(Attrited.avg_revolving_balance - Existing.avg_revolving_balance, Existing.avg_revolving_balance) * 100, 2) AS balance_difference_pct

FROM CustomerAverages AS Existing

CROSS JOIN CustomerAverages AS Attrited

WHERE Existing.Attrition_Flag = 'Existing Customer'
  AND Attrited.Attrition_Flag = 'Attrited Customer';
