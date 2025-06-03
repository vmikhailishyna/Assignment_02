# Assignment_02
# Practical Assignment 2 — Query Optimization

## Objective

The goal of this assignment is to demonstrate your ability to optimize a complex SQL query. You will apply step-by-step improvements and justify each change using proper database terminology and reasoning. You'll also analyze and compare execution plans before and after each optimization.

---

## Requirements

### ✅ Basic Requirements (15 points)

You must complete all of the following:

1. **Start with a complex SQL query**  
   Choose a realistic complex and unoptimized query (e.g., involving joins, aggregations, filters, or subqueries). You can generate it using ChatGPT.

2. **Step-by-step optimization**  
   Refactor the query in **multiple steps**, explaining what you changed and why in each step.

   На першому кроці я створила cte_filtered, яка допомогла виконати фільтрацію один раз, а потім використовувати її знову, а не робити кожен раз одну і ту саму фільтрацію, що значно покрашило час виконання запиту, також логіка фільтрації чітко виділена та ізольована. На другому кроці було стврено cte_aggregation, яка групує по cancer_stage і treatment_type відфільтровані дані з cte_filtered та застосовано агрегатні функції: COUNT, AVG.

3. **Execution Plan Comparison**  
   For each version of your query:
   - Provide an execution plan (e.g., using `EXPLAIN`, `EXPLAIN ANALYZE`).
   - Highlight the key performance metrics (e.g., cost, estimated rows, actual time).

1.1. Explain який зроблений для початкового неоптимізованого запиту: ![image](https://github.com/user-attachments/assets/404790d6-8cfc-4560-aa97-73c0d5bacacd)
Можна побачити що відбувається повне сканування таблиці, а це 881,279 рядків.Жоден індекс не використовується, навіть коли йдуть фільтрації по cancer_stage, treatment_type, age, diagnosis_date, що сповільную запит. Where використовується 6 разів, через що сповільнює роботу запиту.

1.2.EXPLAIN ANALYZE який зроблений для початкового неоптимізованого запиту:![image](https://github.com/user-attachments/assets/35a15479-49ac-4022-a139-802429bbd7b3)

loops = 16:підзапит виконується 16 разів, це значно сповільнюю роботу, бо 16 разів треба пройтись по всій таблиці і відсортувати повторно всі данні які вже були відсортовані.
На виконання запиту було використано 102.891 секунд.

2.1. Explain який зроблений для оптимізованого запиту(без індексації):![image](https://github.com/user-attachments/assets/c14896d5-c030-4c2b-84f2-c22f9a977f8e)
Можна побачити що відбувається повне сканування таблиці лище один раз в порівнянні з попереднім запитом.В цьому запиті, як і в попередньому, жоден індекс не використовується, що сповільную запит. Where використовується лише 1 раз, через що швидкість виконання запиту покращилась.

2.2.EXPLAIN ANALYZE який зроблений для оптимізованого запиту(без індексації):   ![image](https://github.com/user-attachments/assets/586868ff-db28-447a-b4c7-171643a5bdc3)
loops: усі cte запити виконуються один раз
Загальний час виконання = 1.2 с. в порівнянні з попереднім результатом в 102.891 с. видно що запит дійсно опимізований.

2.3.XPLAIN ANALYZE який зроблений для оптимізованого запиту з індексацією показує ![image](https://github.com/user-attachments/assets/64e209fa-4c9b-44e2-ac4c-da0626a3d4d0)
що запит тепер проходиться по меньшо кількістю рядків(867 замість 1286), це доводить що індексація допомогла покращити продуктивність запиту.
4. **Code Refactoring**  
   Refactor the query for improved readability and structure. This may include:
   - Using CTEs
   - Breaking down subqueries
   - Rewriting inefficient joins or filters

5. **Index Optimization**  
   - Identify missing indexes that can improve performance.
   - Add appropriate indexes and explain how they help (e.g., reducing full table scans).
  
     CREATE INDEX index_survived_asthma_cirrhosis_date_age
ON dataset_med (survived, asthma, cirrhosis, diagnosis_date, age);
Було додано складений індекс index_survived_asthma_cirrhosis_date_age для пришвидшення роботи запиту

### 💡 Additional Points (+2)
To earn **up to 2 bonus points**, demonstrate the use of **query hints** where appropriate:
- Show how specific hints (e.g., `USE INDEX`, `FORCE INDEX`, `STRAIGHT_JOIN`, etc.) influence the query plan.
- Justify when and why using hints may be necessary or beneficial.

---

## Submission Format

Please submit the following:

- `README.md` (this file): 
  - Overview of your work
  - Summary of optimization steps and their effects

- `query_versions/` folder:
  - `original_query.sql`: Original complex query
  - `step1_refactor.sql`: First optimization step
  - `step2_indexing.sql`: Index usage optimization
  - Additional steps as needed

- `execution_plans/` folder:
  - Execution plans for each query version (can be screenshots or text files)

- `explanations/` folder:
  - A document (markdown or PDF) where you describe:
    - Each optimization step
    - Why you made the change
    - The impact on performance

---

## Evaluation Criteria

| Criteria                                                   | Points |
|------------------------------------------------------------|--------|
| Step-by-step optimization process                          | 4      |
| Execution plan comparison                                  | 3      |
| Code readability & refactoring                             | 2      |
| Index usage with explanation                               | 2      |
| Terminology accuracy and clarity (2 questions in the  end) | 4      |
| **Bonus: Use of query hints**                              | **+2** |

---

## Notes

- Choose a query that has enough complexity to allow for meaningful optimizations.
- All explanations should be written clearly and concisely.

---

1. What does an index do in a database? 
2. How can adding an index make a query faster? 
3. What is a full table scan, and why is it usually slower than using an index? 
4. How do you check if your query is using an index? 
5. Can having too many indexes slow down your database? Why or why not? 
6. What is the difference between a simple index and a composite index? 
7. When should you consider adding an index to a column? 
8. What is the purpose of EXPLAIN or EXPLAIN ANALYZE in SQL? 
9. How can rewriting a query (refactoring) improve performance? 
10. What is one way to make a join between two large tables faster?

---
