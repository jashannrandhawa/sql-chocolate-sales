# Chocolate Sales SQL Analysis

## Project Overview

This project presents an exploratory data analysis of a chocolate sales database using SQL. Over **20+ SQL queries** were written to analyze revenue trends, product performance, regional sales patterns, and salesperson contributions. The objective was to transform a structured dataset into actionable business insights while demonstrating practical SQL skills across joins, aggregations, window functions, and time-based analysis.

---

## Dataset & Schema

The analysis is based on a relational sales dataset consisting of four tables:

* **Sales:** Order-level data (SaleDate, Amount, Boxes, Customers, PID, GeoID, SPID)
* **Products:** Product details (PID, Product, Category, Size, Cost per box)
* **Geo:** Geography info (GeoID, Geo, Region)
* **People:** Salesperson details (SPID, SalesPerson, Team, Location)

*(A visual ERD is included in the repository as `erd.png`)*

---

## Key Business Questions

This analysis answers **20+ foundational business questions**, including:

 * What are the overall sales, boxes sold, and customers served?
 * Which month generated the highest revenue?
 * Which products generated the most revenue and sold the most boxes?
 * Which product category contributed the most to revenue?
 * Which was the best-selling product for each month of 2021?
 * Which countries and regions bought the most?
 * Which salesperson and sales team generated the most revenue?

---

## SQL Techniques Used

  * **Aggregations:** SUM, COUNT, GROUP BY, HAVING
  * **Joins:** INNER JOIN across multiple tables
  * **Window Functions:** RANK(), LAG()
  * **Date Functions:** YEAR, MONTHNAME, DATE_FORMAT
  * **Subqueries:** Nested and in-line for complex filtering
  * **Conditional Logic:** CASE statements

---

## Sample Insights

* **Overall Performance:** $43.5M total revenue was generated from 2.9M boxes sold to 1.2M customers.
  * **Peak Sales Month:** January 2022 was the best month with $5.2M in revenue.
  * **Top Products:** "After Nines" was the #1 revenue product ($2.1M), while "Orange Choco" sold the most boxes (192K).
  * **Geographic Performance:** The APAC region generated the most revenue overall, with India outperforming Australia in sales for 9 out of 15 months.
  * **Performance Outlier:** Using window functions, I identified a salesperson who achieved a remarkable ~400% month-over-month sales growth, a critical outlier that would warrant immediate business investigation.

---

## How to Run

To replicate this analysis:

1.  Ensure you have a MySQL server running.
2.  Run the `database_setup.sql` script (located in the `data` folder) to create the database and populate it.
3.  You can now run any of the queries from the `chocolate_sales_analysis.sql` file (located in the `queries` folder).

---

## Repository Structure

```
/sql-chocolate-sales
│
├── data/
│   └── database_setup.sql
│
├── queries/
│   └── chocolate_sales_analysis.sql
│
├── erd.png
└── README.md
```

---

## Learnings & Takeaways

   * **Advanced SQL Application:** Strengthened ability to write analytical
  SQL queries using window functions (`LAG()`) to perform time-series
  analysis of sales trends.

   * **From Data to Insight:** Developed experience translating raw query
  outputs into meaningful business insights, including identifying a
  ~400% month-over-month sales spike as a critical performance outlier.

   * **Professional Documentation:** Reinforced best practices in project
  organization through clear folder structure, a visual ERD, and
  reproducible documentation.


