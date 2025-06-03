use assignment02;
show tables;
select * from dataset_med;

explain analyze
SELECT 
    fp.cancer_stage,
    fp.treatment_type,
    (SELECT COUNT(*) 
     FROM dataset_med p 
     WHERE 
         p.survived = 1 
         AND p.asthma = 0 
         AND p.cirrhosis = 0 
         AND p.age > 40 
         AND p.diagnosis_date > '2018-01-01' 
         AND p.cancer_stage IS NOT NULL 
         AND p.treatment_type IS NOT NULL 
         AND p.cancer_stage = fp.cancer_stage 
         AND p.treatment_type = fp.treatment_type) AS survivors_count,
    (SELECT AVG(p.bmi * 1.0) 
     FROM dataset_med p 
     WHERE 
         p.survived = 1 
         AND p.asthma = 0 
         AND p.cirrhosis = 0 
         AND p.age > 40 
         AND p.diagnosis_date > '2018-01-01' 
         AND p.cancer_stage IS NOT NULL 
         AND p.treatment_type IS NOT NULL 
         AND p.cancer_stage = fp.cancer_stage 
         AND p.treatment_type = fp.treatment_type) AS avg_bmi,
    (SELECT AVG(p.cholesterol_level * 1.0) 
     FROM dataset_med p 
     WHERE 
         p.survived = 1 
         AND p.asthma = 0 
         AND p.cirrhosis = 0 
         AND p.age > 40 
         AND p.diagnosis_date > '2018-01-01' 
         AND p.cancer_stage IS NOT NULL 
         AND p.treatment_type IS NOT NULL 
         AND p.cancer_stage = fp.cancer_stage 
         AND p.treatment_type = fp.treatment_type) AS avg_cholesterol,
    CASE 
        WHEN (SELECT AVG(p.age * 1.0) 
              FROM dataset_med p 
              WHERE 
                  p.survived = 1 
                  AND p.asthma = 0 
                  AND p.cirrhosis = 0 
                  AND p.age > 40 
                  AND p.diagnosis_date > '2018-01-01' 
                  AND p.cancer_stage IS NOT NULL 
                  AND p.treatment_type IS NOT NULL 
                  AND p.cancer_stage = fp.cancer_stage 
                  AND p.treatment_type = fp.treatment_type) >= 60 
            THEN 'elderly'
        WHEN (SELECT AVG(p.age * 1.0) 
              FROM dataset_med p 
              WHERE 
                  p.survived = 1 
                  AND p.asthma = 0 
                  AND p.cirrhosis = 0 
                  AND p.age > 40 
                  AND p.diagnosis_date > '2018-01-01' 
                  AND p.cancer_stage IS NOT NULL 
                  AND p.treatment_type IS NOT NULL 
                  AND p.cancer_stage = fp.cancer_stage 
                  AND p.treatment_type = fp.treatment_type) BETWEEN 40 AND 59 
            THEN 'middle-aged'
        ELSE 'young'
    END AS age_group
FROM 
    (SELECT DISTINCT cancer_stage, treatment_type FROM dataset_med WHERE 1=1) fp
WHERE 
    (SELECT COUNT(*) 
     FROM dataset_med p 
     WHERE 
         p.survived = 1 
         AND p.asthma = 0 
         AND p.cirrhosis = 0 
         AND p.age > 40 
         AND p.diagnosis_date > '2018-01-01' 
         AND p.cancer_stage IS NOT NULL 
         AND p.treatment_type IS NOT NULL 
         AND p.cancer_stage = fp.cancer_stage 
         AND p.treatment_type = fp.treatment_type) > 10
ORDER BY 
    survivors_count DESC, avg_bmi DESC;

