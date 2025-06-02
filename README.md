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

4. **Execution Plan Comparison**  
   For each version of your query:
   - Provide an execution plan (e.g., using `EXPLAIN`, `EXPLAIN ANALYZE`).
   - Highlight the key performance metrics (e.g., cost, estimated rows, actual time).

5. **Code Refactoring**  
   Refactor the query for improved readability and structure. This may include:
   - Using CTEs
   - Breaking down subqueries
   - Rewriting inefficient joins or filters

6. **Index Optimization**  
   - Identify missing indexes that can improve performance.
   - Add appropriate indexes and explain how they help (e.g., reducing full table scans).

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

---1. What does an index do in a database? 
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
