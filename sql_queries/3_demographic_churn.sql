SELECT 
    Income_Category,
    COUNT(*) AS total_customers_in_bracket,
    SUM(CASE WHEN Attrition_Flag = 'Attrited Customer' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Attrition_Flag = 'Attrited Customer' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS churn_rate_percentage
FROM `nova_bank_churn.cleaned_customer_data`
GROUP BY Income_Category
ORDER BY churn_rate_percentage DESC;