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


------------------------------------------------------------------------------------------
### Project 3
# Bank Database 
A comprehensive SQL-based data analysis project on a simulated banking database containing **50,000+ customers**, **1,000,000 transactions**, **30,000 loans**, and more. This project covers data cleaning, schema validation, exploratory data analysis (EDA), and business intelligence insights using MySQL.
 
---
 
##  Database Schema
 
The `bank` database consists of **7 core tables**:
 
| Table | Description |
|---|---|
| `customers` | Customer profiles including credit scores and city |
| `accounts` | Bank accounts (Savings, Checking, Business) |
| `transactions` | Financial transactions linked to accounts and merchants |
| `loans` | Loan records with amounts and interest rates |
| `cards` | Debit and credit cards linked to accounts |
| `merchants` | Merchant information for transaction tracking |
| `branches` | Bank branch details across the USA |

 
##  Phase 1: Data Cleaning & Schema Enforcement
 
Before analysis, the dataset was cleaned and constraints were applied:
 
- **NOT NULL constraints** enforced on critical columns (names, emails, dates, amounts)
- **ENUM types** applied to `card_type` (`credit`, `debit`) and `account_type` (`Savings`, `Business`, `Checking`)
- **Decimal precision** standardized on financial columns (`amount_usd`, `loan_amount`, `interest_rate`)
- **NULL checks** performed across all tables — 16 branches found with no manager assigned
- **Foreign key relationships** verified via `information_schema`
 
---
 
##  Phase 2: Exploratory Data Analysis (EDA)
 
### 👥 Customers
- **Total customers:** 50,000
- **Data range:** January 2019 – December 2025
- **Best month for new signups:** November 2025 (657 new customers)
- **Worst month:** February 2019 (492 new customers)
- **Average:** ~595 new customers/month
 
**Credit Score Distribution:**
 
| Category | Score Range | Count |
|---|---|---|
| Very Poor | < 600 | 27,388 |
| Poor | 600–649 | 4,502 |
| Fair | 650–699 | 4,524 |
| Good | 700–749 | 4,547 |
| Excellent | ≥ 750 | 9,039 |
 
>  Over 54% of customers fall in the "Very Poor" credit score category.
 
---
 
### Accounts
- **Max balance:** $199,994.58
- **Min balance:** $13.20
- **Average balance:** ~$100,181
 
**Account type distribution is nearly equal:**
- Checking: 25,090
- Savings: 24,962
- Business: 24,948
 
---
 
###  Branches
- **Total branches:** 500
- **16 branches** have no manager assigned
- **All branches are in the USA**
- A few cities (e.g., Amandaville, West Kevin, South Brian) have multiple branches
 
---
 
###  Cards
- **Debit cards:** 50,281
- **Credit cards:** 49,719
- **Customers holding both card types:** 18,485
 
---
 
### 🏪 Merchants
- **Top merchant by transaction volume:** Lopez PLC (253 transactions)
- **Top merchant by transaction value:** Lopez PLC
- **City with most merchants:** North Robert (8 merchants)
 
> Lopez PLC leads in both transaction count and total value, indicating strong customer engagement.
 
---
 
###  Loans
- **Total loans:** 30,000
- **Min loan amount:** $1,010.16
- **Max loan amount:** $299,975.47
- **Average loan amount:** $150,089.01
 
**Loan size distribution:**
 
| Category | Count |
|---|---|
| Small (< $100K) | 9,970 |
| Medium ($100K–$250K) | 15,083 |
| Large (> $250K) | 4,947 |
 
**Interest rate distribution:**
 
| Category | Rate Range | Count |
|---|---|---|
| Low | < 5% | 6,834 |
| Medium | 5%–10% | 11,606 |
| High | > 10% | 11,560 |
 
> 📊 No significant correlation found between loan size and interest rate — average rates are nearly identical (~8.5%) across all loan sizes.
 
**Multiple loans:**
- 6,038 customers hold more than 1 loan
- 4 customers hold 6 loans each
 
**Seasonal trend:** Loan issuance peaks in January and mid-year months; dips in February and late summer.
 
---
 
###  Transactions
- **Min transaction:** $1.02
- **Max transaction:** $9,999.98
- **Average transaction:** ~$5,000.82
 
**Transaction size distribution:**
 
| Category | Count | % |
|---|---|---|
| Low (< $3,000) | 299,907 | 29.99% |
| Medium ($3,000–$7,000) | 399,782 | 39.98% |
| High (> $7,000) | 300,311 | 30.03% |
 
---
 
##  Phase 3: Risk Analysis
 
### High-Risk Customer Identification
Customers with **credit score < 600** AND **total loan exposure > $300,000** were flagged as high-risk:
 
- **Total high-risk customers:** ~1,935
- **Risk percentage:** **3.87%** of total customer base
 
> These customers represent significant financial risk and should be closely monitored by the bank for potential defaults.
 
---
 
##  Tools & Technologies
 
- **Database:** MySQL
- **IDE:** MySQL Workbench
- **Concepts used:** DDL, DML, JOINs, CTEs, Window Functions, Subqueries, Temporary Tables, CASE statements, Aggregate Functions
 
---
 
##  Key Business Insights
 
1. **Credit risk is concentrated** — over half of customers have very poor credit scores
2. **Lending is stable** — loan issuance fluctuates very little year-over-year (~4,200–4,400/year)
3. **Lopez PLC dominates** merchant activity in both volume and value
4. **18,485 customers** hold both credit and debit cards — a strong cross-product adoption rate
5. **Port David city** generates the highest total loan amounts ($5,389,351.88)
6. **16 branches** are operating without a manager — an operational gap to address
 


