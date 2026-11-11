SELECT 
    Attrition_Flag,
    COUNT(*) AS total_customers,
    ROUND(AVG(Total_Trans_Amt), 2) AS avg_transaction_amount,
    ROUND(AVG(Total_Trans_Ct), 0) AS avg_transaction_count,
    ROUND(AVG(Total_Revolving_Bal), 2) AS avg_revolving_balance,
    ROUND(AVG(Contacts_Count_12_mon), 1) AS avg_service_calls
FROM `nova_bank_churn.cleaned_customer_data`
GROUP BY Attrition_Flag;