# Customer and Sales Performance Analysis (SQL)

A SQL data analysis project using the Northwind sample database, answering six real business questions a company owner would want answered about their customers, employees, products, shipping, and sales trends.

## Tools Used
- SQL (SQLite)
- DB Browser for SQLite

## Dataset
[Northwind SQLite Database](https://github.com/jpwhite3/northwind-SQLite3) — a sample database representing a small business that imports and sells specialty food and beverage products. Tables used include Customers, Orders, Order Details, Products, Employees, and Shippers.

## Business Questions Answered
1. Who are our top 10 customers by spend?
2. Which employee has made the most sales?
3. What are our best- and worst-selling products?
4. Which shipping company do we use most, and is it the fastest?
5. Are there seasonal patterns in order volume?
6. Do bigger discounts lead to bigger order quantities?

## Key Findings
- **Top customer:** B's Beverages, the highest spender after excluding two invalid placeholder customer records found during data cleaning.
- **Top employee:** Margaret Peacock, though sales performance is fairly close across the whole team.
- **Best/worst sellers:** Ranked by quantity sold rather than revenue, since revenue alone is skewed by price differences between products. Quantity sold turned out to be remarkably similar across almost every product, revenue differences are driven mainly by price, not popularity.
- **Shipping:** United Package is both the most-used and fastest shipping company. Speedy Express is the slowest and least-used of the three.
- **Seasonality:** March, August, and July are the busiest months; February and June are the slowest, though the swing is mild.
- **Discounts:** No, bigger discounts do not lead to bigger order quantities. Average order size stays roughly the same (25 to 28 units) regardless of discount level.

## Data Quality Checks
Two data quality issues were found and corrected during this project:
1. Two customer records named "IT" with blank address/contact fields were skewing the top customers result and were excluded.
2. An early best-sellers ranking by revenue overstated the popularity of expensive products; the final analysis ranks by quantity sold instead, with revenue shown as supporting context.

## Files in This Repo
- `scripts/northwind_queries.sql` — all six SQL queries, commented with what each one does and why it matters
- `notes/` — project notes
- `Northwind_SQL_Project_Writeup.pdf` — full client-facing write-up with all results, business context, and recommendations

## Full Write-Up
See the full write-up for detailed tables, business recommendations, and the data quality section: `Northwind_SQL_Project_Writeup.pdf`
