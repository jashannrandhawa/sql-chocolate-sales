#1: What is the total sales amount, total boxes, and total customers overall?

SELECT 
SUM(AMOUNT) AS TOTALAMOUNT,
SUM(BOXES) AS TOTALBOXES,
SUM(CUSTOMERS) AS TOTALCUSTOMERS 
FROM SALES;

#Overall,the company generated $43561546 total sales amount,selling 2901311 boxes to 1232947 customers.

#2: Which month had the highest sales revenue?

SELECT 
    YEAR(SaleDate) AS Year,
    MONTHNAME(SaleDate) AS Month,
    SUM(Amount) AS TotalRevenue
FROM Sales
GROUP BY Year, Month
ORDER BY TotalRevenue DESC
LIMIT 1;

#The month with the highest revenue was January 2022 with total sales of $5280919.

#3: Which products generated the most revenue?(Top 5)

SELECT 
    p.Product,
    SUM(s.Amount) AS TotalRevenue
FROM Sales s
JOIN Products p ON p.PID = s.PID
GROUP BY p.Product
ORDER BY TotalRevenue DESC
LIMIT 5;

#The top 5 revenue-generating products were After Nines,Raspberry Choco,Almond Choco,99% Dark & Pure,Organic Choco Syrup with Product After Nines leading at $2112502 total revenue.

#4: Which products sold the most boxes?(Top 5)

SELECT 
    p.Product,
    SUM(s.Boxes) AS TotalBoxes
FROM Sales s
JOIN Products p ON p.PID = s.PID
GROUP BY p.Product
ORDER BY TotalBoxes DESC
LIMIT 5;

#The top 5 products sold by boxes were Orange Choco,White Choc,Organic Choco Syrup,Manuka Honey Choco,Eclairs with Product Orange Choco selling the highest at 192189 boxes.

#5: Which product category ("Bars","Bites","Other") contributed the most to revenue?

SELECT 
    p.Category,
    SUM(s.Amount) AS TotalRevenue
FROM Sales s
JOIN Products p ON p.PID = s.PID
GROUP BY p.Category
ORDER BY TotalRevenue DESC
LIMIT 1;

#The product category contributing the most to revenue was Bars,with total sales of $21746501.

#6: How do "Milk Bars" and "Eclairs" compare in terms of total boxes sold?

SELECT 
    p.Product,
    SUM(s.Boxes) AS TotalBoxes
FROM Sales s
JOIN Products p ON p.PID = s.PID
WHERE p.Product IN ('Milk Bars','Eclairs')
GROUP BY p.Product
ORDER BY TotalBoxes DESC;

#Eclairs sold a total of 13,0995 boxes,while Milk Bars sold 14,4651 boxes - meaning Milk Bars outsold Eclairs by 10.5%.

#7: Which was the best-selling product in each month of 2021?

SELECT 
    YearMonth,
    Product,
    TotalBoxes
FROM (
    SELECT 
        DATE_FORMAT(s.SaleDate, '%Y-%m') AS YearMonth,
        p.Product,
        SUM(s.Boxes) AS TotalBoxes,
        RANK() OVER (PARTITION BY DATE_FORMAT(s.SaleDate, '%Y-%m') 
                     ORDER BY SUM(s.Boxes) DESC) AS rnk
    FROM Sales s
    JOIN Products p ON p.PID = s.PID
    WHERE YEAR(s.SaleDate) = 2021
    GROUP BY YearMonth, p.Product
) ranked
WHERE rnk = 1
ORDER BY YearMonth;

#In 2021,best-selling products shifted monthly - Organic Choco Syrup and Orange Choco led 3 months each,while White Choc,Eclairs,Manuka Honey Choco,Milk Bars,and 50% Dark Bites topped the rest.

#8: Which countries bought the most chocolate boxes overall?

SELECT 
    g.geo as country,
    SUM(s.Boxes) AS TotalBoxes
FROM Sales s
JOIN Geo g ON g.GeoID = s.GeoID
GROUP BY country
ORDER BY TotalBoxes DESC;

#New Zealand purchased the most boxes overall,representing the biggest international market.

#9: Which region (APAC, Americas, Europe) generated the most revenue?

SELECT 
    g.Region,
    SUM(s.Amount) AS TotalRevenue
FROM Sales s
JOIN Geo g ON g.GeoID = s.GeoID
GROUP BY g.Region
ORDER BY TotalRevenue DESC
LIMIT 1;

#The APAC region led in revenue generation,making it the most profitable geography.

#10: Did "After Nines" sell in every month in New Zealand?

SELECT 
    CASE 
        WHEN COUNT(DISTINCT DATE_FORMAT(s.SaleDate, '%Y-%m')) = 
             (SELECT COUNT(DISTINCT DATE_FORMAT(SaleDate, '%Y-%m')) FROM Sales)
        THEN 'Yes'
        ELSE 'No'
    END AS SoldEveryMonth
FROM Sales s
JOIN Products p ON p.PID = s.PID
JOIN Geo g ON g.GeoID = s.GeoID
WHERE p.Product = 'After Nines'
  AND g.geo = 'New Zealand';

#After Nines sold consistently every month in New Zealand, showing stable demand.


#11: Between India and Australia,which country bought more boxes on a monthly basis?

SELECT 
    YearMonth,
    geo,
    TotalBoxes
FROM (
    SELECT 
        DATE_FORMAT(s.SaleDate, '%Y-%m') AS YearMonth,
        g.geo,
        SUM(s.Boxes) AS TotalBoxes,
        RANK() OVER (PARTITION BY DATE_FORMAT(s.SaleDate, '%Y-%m') 
                     ORDER BY SUM(s.Boxes) DESC) AS rnk
    FROM Sales s
    JOIN Geo g ON g.GeoID = s.GeoID
    WHERE g.geo IN ('India', 'Australia')
    GROUP BY YearMonth, g.geo
) ranked
WHERE rnk = 1
ORDER BY YearMonth;

#India outperformed Australia in 9 of the 15 months,while Australia led in 6 months,showing India as the stronger market overall.

#12: How many shipments did each salesperson handle in January 2022?

SELECT 
    sp.SalesPerson,
    COUNT(*) AS TotalShipments
FROM Sales s
JOIN People sp ON sp.SPID = s.SPID
WHERE s.SaleDate BETWEEN '2022-01-01' AND '2022-01-31'
GROUP BY sp.SalesPerson
ORDER BY TotalShipments DESC;

#In January 2022,Roddy Speechley led with 47 shipments,followed closely by Kelci Walkden and Gunar Cockshoot with 44 each.  

#13: Which salesperson sold the most boxes overall?

SELECT 
    sp.SalesPerson,
    SUM(s.Boxes) AS TotalBoxes
FROM Sales s
JOIN People sp ON sp.SPID = s.SPID
GROUP BY sp.SalesPerson
ORDER BY TotalBoxes DESC
LIMIT 1;

#Madelene Upcott sold the most boxes overall,with a total of 129,665. 
 
#14: Which salesperson generated the highest revenue in 2021?

SELECT 
    sp.SalesPerson,
    SUM(s.Amount) AS TotalRevenue
FROM Sales s
JOIN People sp ON sp.SPID = s.SPID
WHERE YEAR(s.SaleDate) = 2021
GROUP BY sp.SalesPerson
ORDER BY TotalRevenue DESC
LIMIT 1;

#In 2021,Barr Faughny generated the highest revenue, totaling $1,463,035.  


#15: Which salespersons had no sales in the first 7 days of January 2022?

SELECT 
    sp.SalesPerson
FROM People sp
WHERE sp.SPID NOT IN (
    SELECT DISTINCT s.SPID
    FROM Sales s
    WHERE s.SaleDate BETWEEN '2022-01-01' AND '2022-01-07'
)
ORDER BY sp.SalesPerson;

#8 salespersons had no sales in the first 7 days of January 2022,including Benny Karolovsky and Dyna Doucette.  

#16: Which team (Yummies,Delish,Jucies) performed the best in terms of sales amount?

SELECT 
    sp.Team,
    SUM(s.Amount) AS TotalRevenue
FROM Sales s
JOIN People sp ON sp.SPID = s.SPID
GROUP BY sp.Team
ORDER BY TotalRevenue DESC
LIMIT 1;

#Team Delish performed the best,generating total sales of $13,853,154.  

#17: List shipments where amount > 2,000 and boxes < 100

SELECT 
    s.Spid,
    s.SaleDate,
    p.Product,
    g.geo,
    sp.SalesPerson,
    s.Boxes,
    s.Amount
FROM Sales s
JOIN Products p ON p.PID = s.PID
JOIN Geo g ON g.GeoID = s.GeoID
JOIN People sp ON sp.SPID = s.SPID
WHERE s.Amount > 2000 
  AND s.Boxes < 100
ORDER BY s.SaleDate;

#47 shipments had amount > 2,000 and boxes < 100,highlighting high-value but low-volume orders.

#18: List shipments with under 100 customers and under 100 boxes and check if any occurred on a Wednesday.

SELECT 
    s.SPID,
    s.SaleDate,
    p.Product,
    g.geo,
    sp.SalesPerson,
    s.Boxes,
    s.Customers,
    s.Amount,
    DAYNAME(s.SaleDate) AS DayOfWeek
FROM Sales s
JOIN Products p ON p.PID = s.PID
JOIN Geo g ON g.GeoID = s.GeoID
JOIN People sp ON sp.SPID = s.SPID
WHERE s.Customers < 100
  AND s.Boxes < 100
ORDER BY s.SaleDate;

#Multiple shipments with under 100 customers and under 100 boxes were identified,including several that occurred on Wednesdays.  

#19: How many times did we ship more than 1,000 boxes in a single order, by month?

SELECT 
    DATE_FORMAT(s.SaleDate, '%Y-%m') AS YearMonth,
    COUNT(*) AS ShipmentsOver1000
FROM Sales s
WHERE s.Boxes > 1000
GROUP BY YearMonth
ORDER BY YearMonth;

#Shipments exceeding 1,000 boxes peaked in January 2022 with 88 occurrences,while monthly counts otherwise ranged between 15 and 38.  

#20: On which dates did we record the highest number of customers served?

SELECT 
    s.SaleDate,
    SUM(s.Customers) AS TotalCustomers
FROM Sales s
GROUP BY s.SaleDate
HAVING SUM(s.Customers) = (
    SELECT MAX(DailyCustomers)
    FROM (
        SELECT SUM(Customers) AS DailyCustomers
        FROM Sales
        GROUP BY SaleDate
    ) t
)
ORDER BY s.SaleDate;

#The highest number of customers served in a single day was 10,873 on January 7, 2022.  

#21: Which salesperson showed the best month-over-month revenue growth in 2022?

SELECT
    Salesperson,
    sale_month,
    monthly_sales,
    previous_month_sales,
    CASE
        WHEN previous_month_sales = 0 THEN 0
        ELSE ((monthly_sales - previous_month_sales) / previous_month_sales) * 100
    END AS mom_growth_percentage
FROM (
    SELECT
        Salesperson,
        sale_month,
        monthly_sales,
        LAG(monthly_sales, 1, 0) OVER (PARTITION BY Salesperson ORDER BY sale_month) AS previous_month_sales
    FROM (
        SELECT
            sp.Salesperson,
            DATE_FORMAT(s.SaleDate, '%Y-%m') AS sale_month,
            SUM(s.Amount) AS monthly_sales
        FROM Sales s
        JOIN People sp ON sp.SPID = s.SPID
        WHERE YEAR(s.SaleDate) = 2022
        GROUP BY sp.Salesperson, sale_month
    ) AS monthly_sales_data
) AS sales_with_previous
ORDER BY mom_growth_percentage DESC
LIMIT 1;

#The data shows that Marney O'Breen had the single best performance spike in 2022, increasing her sales by an incredible 397.4% from February to March.











