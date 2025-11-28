
SHOW VARIABLES LIKE 'secure_file_priv';

CREATE DATABASE IF NOT EXISTS ecommerce_db
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

USE ecommerce_db;
DROP TABLE IF EXISTS staging_raw;

CREATE TABLE staging_raw (
  TransactionNo VARCHAR(50),
  Date VARCHAR(50),
  ProductNo VARCHAR(50),
  ProductName VARCHAR(255),
  Price VARCHAR(50),
  Quantity VARCHAR(50),
  CustomerNo VARCHAR(50),
  Country VARCHAR(100)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Sales Transaction v.4a.csv'
INTO TABLE staging_raw
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(TransactionNo, Date, ProductNo, ProductName, Price, Quantity, CustomerNo, Country);

# creating a clean table
USE ecommerce_db;

DROP TABLE IF EXISTS clean_transactions;

DROP TABLE IF EXISTS clean_transactions;
CREATE TABLE clean_transactions (
  TransactionNo VARCHAR(50),   
  Date DATE,
  ProductNo VARCHAR(50),
  ProductName VARCHAR(255),
  Price DECIMAL(10,2),
  Quantity INT,
  CustomerNo VARCHAR(50),     
  Country VARCHAR(100)
);

INSERT INTO clean_transactions
SELECT
  TransactionNo,
  CASE
    WHEN Date REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$'
         AND SUBSTRING_INDEX(Date, '/', 1) > 12
         THEN STR_TO_DATE(Date, '%d/%m/%Y')
    ELSE STR_TO_DATE(Date, '%m/%d/%Y')
  END AS Date,
  ProductNo,
  ProductName,
  CAST(Price AS DECIMAL(10,2)) AS Price,
  CASE
    WHEN Quantity REGEXP '^-?[0-9]+$' THEN CAST(Quantity AS SIGNED)
    ELSE NULL
  END AS Quantity,
  CustomerNo,
  Country
FROM staging_raw
WHERE TransactionNo IS NOT NULL;


# Transaction

DROP TABLE IF EXISTS Transactions;

CREATE TABLE Transactions (
  TransactionNo VARCHAR(50) PRIMARY KEY,
  Date DATE,
  CustomerNo VARCHAR(50),
  Country VARCHAR(100)
);

INSERT INTO Transactions
SELECT DISTINCT
  TransactionNo,
  Date,
  CustomerNo,
  Country
FROM clean_transactions;

# Product

DROP TABLE IF EXISTS Products;

CREATE TABLE Products (
  ProductNo VARCHAR(50) PRIMARY KEY,
  ProductName VARCHAR(255),
  Price DECIMAL(10,2)
);

INSERT INTO Products (ProductNo, ProductName, Price)
SELECT t.ProductNo,
       -- pick one name (if multiple exist, MIN() will choose alphabetically)
       MIN(t.ProductName) AS ProductName,
       -- pick the MAX price on the latest date
       MAX(t.Price) AS Price
FROM clean_transactions t
JOIN (
    SELECT ProductNo, MAX(Date) AS LatestDate
    FROM clean_transactions
    GROUP BY ProductNo
) latest
  ON t.ProductNo = latest.ProductNo
 AND t.Date = latest.LatestDate
GROUP BY t.ProductNo;

# transactionDetails

DROP TABLE IF EXISTS TransactionDetails;

CREATE TABLE TransactionDetails (
  TransactionNo VARCHAR(50),
  ProductNo VARCHAR(50),
  Quantity INT,
  FOREIGN KEY (TransactionNo) REFERENCES Transactions(TransactionNo),
  FOREIGN KEY (ProductNo) REFERENCES Products(ProductNo)
);

INSERT INTO TransactionDetails
SELECT
  TransactionNo,
  ProductNo,
  Quantity
FROM clean_transactions;

# Total Revenue

SELECT ROUND(SUM(p.Price * d.Quantity),2) AS TotalRevenue
FROM TransactionDetails d
JOIN Products p ON d.ProductNo = p.ProductNo;

# Revenue by Country

SELECT t.Country, ROUND(SUM(p.Price * d.Quantity),2) AS Revenue
FROM TransactionDetails d
JOIN Transactions t ON d.TransactionNo = t.TransactionNo
JOIN Products p ON d.ProductNo = p.ProductNo
GROUP BY t.Country
ORDER BY Revenue DESC;

# Mounthly Sales Trends

SELECT DATE_FORMAT(t.Date, '%Y-%m') AS Month,
       ROUND(SUM(p.Price * d.Quantity),2) AS Revenue
FROM TransactionDetails d
JOIN Transactions t ON d.TransactionNo = t.TransactionNo
JOIN Products p ON d.ProductNo = p.ProductNo
GROUP BY Month
ORDER BY Month;

# Top 10 Products

SELECT p.ProductName,
       SUM(d.Quantity) AS UnitsSold,
       ROUND(SUM(p.Price * d.Quantity),2) AS Revenue
FROM TransactionDetails d
JOIN Products p ON d.ProductNo = p.ProductNo
GROUP BY p.ProductName
ORDER BY Revenue DESC
LIMIT 10;

# Top Customers by Revenue

SELECT t.CustomerNo,
       ROUND(SUM(p.Price * d.Quantity),2) AS Revenue,
       COUNT(DISTINCT t.TransactionNo) AS Orders
FROM TransactionDetails d
JOIN Transactions t ON d.TransactionNo = t.TransactionNo
JOIN Products p ON d.ProductNo = p.ProductNo
GROUP BY t.CustomerNo
ORDER BY Revenue DESC
LIMIT 10;

# Average Order Value (AOV)

SELECT ROUND(SUM(p.Price * d.Quantity)/COUNT(DISTINCT d.TransactionNo),2) AS AvgOrderValue
FROM TransactionDetails d
JOIN Products p ON d.ProductNo = p.ProductNo;

# Returns / Canceled Orders

SELECT COUNT(*) AS ReturnOrders,
       ROUND(SUM(p.Price * d.Quantity),2) AS LossAmount
FROM TransactionDetails d
JOIN Products p ON d.ProductNo = p.ProductNo
WHERE d.Quantity < 0;

# Repeat Customer Rate

SELECT 
  COUNT(DISTINCT CASE WHEN OrderCount > 1 THEN CustomerNo END) / COUNT(DISTINCT CustomerNo) * 100 AS RepeatCustomerPercent
FROM (
    SELECT CustomerNo, COUNT(DISTINCT TransactionNo) AS OrderCount
    FROM Transactions
    GROUP BY CustomerNo
) t;


# Peak Sales Day of Week

SELECT DAYNAME(t.Date) AS DayOfWeek,
       ROUND(SUM(p.Price * d.Quantity),2) AS Revenue
FROM TransactionDetails d
JOIN Transactions t ON d.TransactionNo = t.TransactionNo
JOIN Products p ON d.ProductNo = p.ProductNo
GROUP BY DayOfWeek
ORDER BY Revenue DESC;










