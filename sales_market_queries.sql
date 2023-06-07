-- Supermarket Sales Analysis

-- DATA WRANGLING
SELECT *
FROM supermarket_sales
WHERE InvoiceID IS NULL 
    OR Branch IS NULL 
    OR City IS NULL 
    OR Customertype IS NULL 
    OR Gender IS NULL 
    OR Productline IS NULL 
    OR Unitprice IS NULL 
    OR Quantity IS NULL 
    OR `Tax5%` IS NULL 
    OR Total IS NULL 
    OR Date IS NULL 
    OR Time IS NULL 
    OR Payment IS NULL 
    OR Cogs IS NULL 
    OR grossmarginpercentage IS NULL 
    OR grossincome IS NULL 
    OR Rating IS NULL;
-- Tidak ditemukan adannya missing value

-- Melihat jika ada data duplikat
SELECT InvoiceID, Branch, City, Customertype, Gender, Productline, Unitprice, Quantity, `Tax5%`, Total, Date, Time, Payment, Cogs, grossmarginpercentage, grossincome, Rating, COUNT(*) AS total_duplikat
FROM supermarket_sales
GROUP BY InvoiceID, Branch, City, Customertype, Gender, Productline, Unitprice, Quantity, `Tax5%`, Total, Date, Time, Payment, Cogs, grossmarginpercentage, grossincome, Rating
HAVING COUNT(*) > 1;
-- Tidak ada data duplikat. Lanjut ke proses analisa

-- ANALYZE PROCESS (To answer some questions)
-- Q1: Which branch has the best results in the loyalty program?
SELECT Branch, SUM(Total) AS TotalSales
FROM supermarket_sales
WHERE Customertype = 'Member'
GROUP BY Branch
ORDER BY TotalSales DESC
LIMIT 1;

-- Q2: Does the membership depend on customer rating?
SELECT Customertype, AVG(Rating) AS AvgRating
FROM supermarket_sales
GROUP BY Customertype;
-- Tipe pelanggan cenderung memosisikan mereka sebagai pelanggan non-member

-- Q3: Does gross revenue depend on the proportion of customers in the loyalty program? What is the relationship with the payment method?
SELECT Customertype, Payment, SUM(grossincome) AS TotalGrossIncome
FROM supermarket_sales
GROUP BY Customertype, Payment;
/* Pada tipe pelanggan member angka revenue tertinggi di angka 2751.0225 dengan metode permbayaran Credit Card,
sedangkan pada tipe non-member angka tertinggi pada 2771.531 dengan metode pembayaran Ewallet */

-- Q4: Are there any differences in indicators between customers who are men and women?
SELECT Gender, AVG(Rating) AS AvgRating, AVG(Total) AS AvgTotal
FROM supermarket_sales
GROUP BY Gender;

-- Q5: Which product category generates the highest income?
SELECT Productline, SUM(Total) AS TotalSales
FROM supermarket_sales
GROUP BY Productline
ORDER BY TotalSales DESC
LIMIT 1;
-- Product makanan dan minuman menjadi product line dengan nilai penjualan tertinggi

-- Q6: Is there a difference in sales results between branches in different cities?
SELECT City, Branch, SUM(Total) AS TotalSales
FROM supermarket_sales
GROUP BY City, Branch;
-- Cabang C di kota Naypyitaw menjadi cabang dengan total nilai penjualan tertinggi

-- Q7: What are the sales trends from time to time? Is there a seasonal pattern or trend of increase/decrease in income?
SELECT Date, SUM(Total) AS TotalSales
FROM supermarket_sales
GROUP BY Date
ORDER BY Date;

-- Q8: Is there a relationship between customer ratings (Rating) and the number of products purchased or their total shopping?
SELECT Rating, AVG(Quantity) AS AvgQuantity, SUM(Total) AS TotalSales
FROM supermarket_sales
GROUP BY Rating;

-- Q9: How is the distribution of payment types among customers with membership and non-member customers?
SELECT Customertype, Payment, COUNT(*) AS TotalTransactions
FROM supermarket_sales
GROUP BY Customertype, Payment;

-- Q10: Is there a difference in the types of products purchased by membership customers and non-member customers?
SELECT Customertype, Productline, COUNT(*) AS TotalTransactions
FROM supermarket_sales
GROUP BY Customertype, Productline;

-- Q11: Is there a correlation between the product unit price and the customer's total spending?
SELECT Unitprice, SUM(Total) AS TotalSales
FROM supermarket_sales
GROUP BY Unitprice;

-- Q12: What is the relationship between gross income and operational costs (COGS)?
SELECT Cogs, SUM(grossincome) AS TotalGrossIncome
FROM supermarket_sales
GROUP BY Cogs;

-- Q13: Is there a trend of change in gross income or total spending over time?
SELECT Date, SUM(grossincome) AS TotalGrossIncome, SUM(Total) AS TotalSales
FROM supermarket_sales
GROUP BY Date
ORDER BY Date;

-- Q14: Is there a difference in gross income between male and female customers in a given product category?
SELECT Gender, Productline, SUM(grossincome) AS TotalGrossIncome
FROM supermarket_sales
GROUP BY Gender, Productline;

-- Q15: How is the distribution of customer ratings in each branch?
SELECT Branch, Rating, COUNT(*) AS TotalCustomers
FROM supermarket_sales
GROUP BY Branch, Rating;






