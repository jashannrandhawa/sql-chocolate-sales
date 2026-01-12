# Chocolate Sales SQL Analysis

## Project Overview

This project began by solving a set of 10 intermediate and hard SQL problems from an online tutorial. After successfully completing these initial challenges, I expanded the scope to a full exploratory data analysis, writing over 20 queries to uncover insights on total revenue, product performance, and regional sales. The goal was to transform a guided exercise into a comprehensive portfolio piece that demonstrates a wide range of SQL skills.

-----

## Dataset & Schema

The dataset and the initial 10 challenge questions were provided by **[https://chandoo.org/wp/learn-sql-for-data-analysis]**.

My work involved solving the initial 10 problems and then independently developing and answering an additional 11+ questions to create a more complete analysis.

The dataset consists of four main tables:

  * **Sales:** Order-level data (SaleDate, Amount, Boxes, Customers, PID, GeoID, SPID)
  * **Products:** Product details (PID, Product, Category, Size, Cost per box)
  * **Geo:** Geography info (GeoID, Geo, Region)
  * **People:** Salesperson details (SPID, SalesPerson, Team, Location)

*(A visual ERD is included in the repository as `erd.png`)*

-----

## Key Business Questions

This analysis answers 20+ foundational business questions, including:

  * What are the overall sales, boxes sold, and customers served?
  * Which month generated the highest revenue?
  * Which products generated the most revenue and sold the most boxes?
  * Which product category contributed the most to revenue?
  * Which was the best-selling product for each month of 2021?
  * Which countries and regions bought the most?
  * Which salesperson and sales team generated the most revenue?

-----

## SQL Techniques Used

  * **Aggregations:** SUM, COUNT, GROUP BY, HAVING
  * **Joins:** INNER JOIN across multiple tables
  * **Window Functions:** RANK(), LAG()
  * **Date Functions:** YEAR, MONTHNAME, DATE\_FORMAT
  * **Subqueries:** Nested and in-line for complex filtering
  * **Conditional Logic:** CASE statements

-----

## Sample Insights

  * **Overall Performance:** $43.5M total revenue was generated from 2.9M boxes sold to 1.2M customers.
  * **Peak Sales Month:** January 2022 was the best month with $5.2M in revenue.
  * **Top Products:** "After Nines" was the \#1 revenue product ($2.1M), while "Orange Choco" sold the most boxes (192K).
  * **Geographic Performance:** The APAC region generated the most revenue overall, with India outperforming Australia in sales for 9 out of 15 months.
  * **Performance Outlier:** Using window functions, I identified a salesperson who achieved a remarkable **\~400% month-over-month sales growth**, a critical outlier that would warrant immediate business investigation.

-----

## How to Run

To replicate this analysis:

1.  Ensure you have a MySQL server running.
2.  Run the `database_setup.sql` script (located in the `data` folder) to create the database and populate it.
3.  You can now run any of the queries from the `chocolate_sales_analysis.sql` file (located in the `queries` folder).

-----

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

-----

## Learnings & Takeaways

  * **Advanced SQL Application:** This project was a valuable opportunity to move from basic queries to more advanced techniques. I gained hands-on experience using **window functions (`LAG()`)** to perform a time-series analysis of sales trends.
  * **From Data to Insight:** A key takeaway was the process of translating a technical query result into a meaningful business finding. Identifying the \~400% sales spike and understanding its significance as a business outlier was a practical exercise in data interpretation.
  * **Professional Documentation:** I focused on professional habits by structuring the project with a clean folder system, a visual ERD, and a comprehensive `README` file to make my work clear and accessible to others.
