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




------------------------------------------------------------------------------------------------------

## Project 2: Global Superstore Analysis
Dataset: Global Superstore (51,225 transactions, 2011-2014)

### Data Cleaning
- Loaded CSV with VARCHAR then converted to proper types
- Fixed date format from MM/DD/YYYY to DATE
- Removed 65 duplicate rows using ROW_NUMBER()

### Key Business Questions & Findings

| # | Question | Finding |
|---|---|---|
| 1 | Best market? | APAC leads ($3.5M sales) |
| 2 | Most efficient market? | Canada (26.62% margin) |
| 3 | Why EMEA underperforms? | Highest discount rate |
| 4 | Best category? | Technology leads |
| 5 | Shipping analysis | Max 7 days, avg 4 days |
| 6 | Best segment? | Consumer volume, Home Office efficiency |
| 7 | Regional performance? | Central leads, Southeast Asia concerning |
| 8 | Discount impact? | High discounts = -42% margin |
| 9 | YoY growth? | 19-27% consistent growth |
| 10 | Top products? | Technology dominates top 10 |

### Key Theme
> Discount rate is the #1 enemy of profitability
> across all markets, regions and categories.

### Skills Used
- Advanced Window Functions (LAG, RANK, ROW_NUMBER)
- CTEs (multiple chained)
- CASE WHEN pivoting
- Date functions (DATEDIFF, STR_TO_DATE)
- Business metric calculations (margin, growth %)

