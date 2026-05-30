CREATE DATABASE ProjectOne

USE ProjectOne

SELECT * FROM [dbo].[ProjectOne$]

--ExtractING FirstName and Surname from the table					

SELECT CustomerFullName, LEFT(CustomerFullName, CHARINDEX(',', CustomerFullName) - 1) AS FirstName
FROM [dbo].[ProjectOne$]

SELECT CustomerFullName, RIGHT(CustomerFullName, LEN(CustomerFullName) - CHARINDEX(',', CustomerFullName)) AS Surname
FROM [dbo].[ProjectOne$]


-- Customers who were given birth to between 12 midnight and 6am 					

SELECT CustomerFullName, CAST(Customer_DOB AS TIME) AS BirthTime FROM [dbo].[ProjectOne$]
WHERE CAST(Customer_DOB AS TIME) BETWEEN '00:00:00' AND '06:00:00';


--All product that were returned						

SELECT ProductID, Product_Name, Return_Flag
FROM [dbo].[ProjectOne$]
WHERE Return_Flag = 'RT'


--Sales_Date to dd/mm/yy format					

SELECT Sales_Date, FORMAT(Sales_Date, 'dd/MM/yy') AS Month_Year
FROM [dbo].[ProjectOne$]


--When Return_Flag is RT decrease Sales by 5%, else increase sales by 9%
					

SELECT CustomerFullName, ProductID, Sales, Return_Flag,
CASE WHEN Return_Flag = 'RT' THEN Sales * 0.95 ELSE Sales * 1.09 END AS NewSales
FROM [dbo].[ProjectOne$]


--Based on the answer from Q5 ( NewSales). Finding the profit/Loss with the HINT NewSales-Cost

SELECT CustomerFullName, ProductID, Sales, Cost, Return_Flag,
    -- Calculate NewSales
CASE WHEN Return_Flag = 'RT' THEN Sales * 0.95 ELSE Sales * 1.09 END AS NewSales,
    -- Calculate Profit/Loss
CASE WHEN Return_Flag = 'RT' THEN Sales * 0.95 ELSE Sales * 1.09 END - Cost AS Profit_Loss
FROM [dbo].[ProjectOne$]

--Using a function to find the quarters from OrderDate column							

SELECT CustomerFullName, ProductID, Sales_Date,
DATEPART(quarter, Sales_Date) AS OrderQuarter
FROM [dbo].[ProjectOne$]


--Product Name with the Initial

SELECT Product_Name, Product_Name + ' ' + LEFT(Product_Name, 1) AS Product_With_Initial
FROM [dbo].[ProjectOne$]


--All produt that cost more than 9000		

SELECT ProductID, Product_Name, Cost
FROM [dbo].[ProjectOne$]
WHERE Cost > 9000