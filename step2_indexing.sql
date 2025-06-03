use assignment02;
SHOW INDEXES FROM dataset_med;
CREATE INDEX idx_filter
ON dataset_med(survived, asthma, cirrhosis, age, diagnosis_date, cancer_stage, treatment_type);

explain analyze
WITH cte_filtered AS (
    SELECT * 
    FROM dataset_med
    WHERE survived = 1 
      AND asthma = 0 
      AND cirrhosis = 0 
      AND age > 40 
      AND diagnosis_date > '2018-01-01' 
      AND cancer_stage IS NOT NULL 
      AND treatment_type IS NOT NULL
), 
cte_aggregation AS (
    SELECT 
        cancer_stage,
        treatment_type,
        COUNT(*) AS survivors_count,
        AVG(bmi) AS avg_bmi,
        AVG(cholesterol_level) AS avg_cholesterol,
        AVG(age) AS avg_age
    FROM cte_filtered
    GROUP BY cancer_stage, treatment_type
)
SELECT 
    cancer_stage,
    treatment_type,
    survivors_count,
    avg_bmi,
    avg_cholesterol,
    CASE 
        WHEN avg_age >= 60 THEN 'elderly'
        WHEN avg_age BETWEEN 40 AND 59 THEN 'middle-aged'
        ELSE 'young'
    END AS age_group
FROM 
    cte_aggregation
WHERE 
    survivors_count > 10
ORDER BY 
    survivors_count DESC, avg_bmi DESC;
