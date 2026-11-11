-- Create a clean working table for our financial churn analysis
CREATE OR REPLACE TABLE `nova_bank_churn.cleaned_customer_data` AS
SELECT DISTINCT * EXCEPT(
    CLIENTNUM,
    Naive_Bayes_Classifier_Attrition_Flag_Card_Category_Contacts_Count_12_mon_Dependent_count_Education_Level_Months_Inactive_12_mon_1,
    Naive_Bayes_Classifier_Attrition_Flag_Card_Category_Contacts_Count_12_mon_Dependent_count_Education_Level_Months_Inactive_12_mon_2
)
FROM `nova_bank_churn.bank_churners`;