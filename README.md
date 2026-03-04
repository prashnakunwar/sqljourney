# sqljourney

I fetched dataset from kaggle : https://www.kaggle.com/datasets/berkayalan/ecommerce-sales-dataset
2 tables:
- `customer_details` — customer info
- `basket_details` — purchase history


### Problem 1: No Primary Keys
- Added `customer_id` as PRIMARY KEY 
  in `customer_details`
- Added `basket_id` as PRIMARY KEY 
  with AUTO_INCREMENT in `basket_details`

### Problem 2: Duplicate Rows
Found duplicates using ROW_NUMBER()
**Result: Deleted 1698 duplicate rows!**

#### Analysis & Findings 

### Q1 — Customers Above Average Basket Count
Finding: Average basket = 2.15 
Most customers buy above average!

### Q2 — Top 3 Customers by Total Purchases
| customer_id | totalcount |
|-------------|------------|
| 8276934 | 25 |
| 22988999 | 18 |
| 11082470 | 15 |

### Q3 — Customers Who Never Purchased
Finding: 19,200 customers 
never made a single purchase!
Huge marketing opportunity!

### Q4 — Customers Above Their Age Group Average
Finding: 1698 customers buy 
more than their age group average!

### Q5 — Customers Above Overall Average (with demographics)
Finding: 1698 customers buy 
above the overall average!

### Q6 — Average Basket Count by Gender
Female customers buy more 
per basket than male customers!


### Key Learnings 

| Concept          | When to use |

| GROUP BY         | One row per group |
| Window Function   | Keep all rows + add calculation |
| PARTITION BY      | Compare within a group |
| NOT IN            | Find missing records |
| LEFT JOIN + NULL  | Find unmatched records |


## Skills Used 
- MySQL
- JOINs (INNER, LEFT)
- Subqueries (nested)
- Window Functions (ROW_NUMBER, AVG OVER)
- Data Cleaning
- Aggregate Functions



