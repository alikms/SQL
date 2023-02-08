USE TSTM
--SELECT * FROM INFORMATION_SCHEMA.TABLES
--SaleTable
--Profit_ratio
SELECT * FROM SALETABLE
SELECT * FROM Profit_ratio
;
INSERT INTO profit_ratio SELECT DISTINCT product,0.1 FROM SaleTable 
WHERE product not in (SELECT product FROM profit_ratio)
;
--1
SELECT SUM(quantity*UnitPrice) AS TOTAL_SALE FROM SaleTable ;
--2
SELECT COUNT(DISTINCT Customer) AS TOTAL_CUSTOMERS FROM SaleTable;
--3
SELECT product,SUM(quantity*unitPrice) AS SALE_PER_PRODUCT FROM SaleTable GROUP BY product;
--4.1
SELECT customer,SUM(quantity*UnitPrice) AS TOTAL,COUNT(orderID) AS NUMBEROFORDERS,SUM(quantity)TOTALITEMS
FROM SaleTable WHERE customer IN
(SELECT customer FROM SaleTable GROUP BY customer,orderid 
HAVING SUM(quantity*UnitPrice)>1500 )
GROUP BY customer
--4.2
SELECT customer,SUM(quantity*UnitPrice) AS TOTAL,COUNT(orderID) AS NUMBEROFORDERS,COUNT(DISTINCT product)TOTALITEMS
FROM SaleTable WHERE customer IN
(SELECT customer FROM SaleTable GROUP BY customer,orderid 
HAVING SUM(quantity*UnitPrice)>1500 )
GROUP BY customer
--5
SELECT SUM(quantity*UnitPrice*p.profitRatio) AS TOTALPROFIT ,CONCAT(SUM(quantity*profitRatio),'%') AS ProfitperCapita
FROM SaleTable AS S FULL JOIN profit_ratio AS P ON P.product=s.product 
--6
SELECT SUM(DATECUSTOMERS)AS TOTALCUSTOMERSBYDATE FROM
(SELECT date,COUNT(DISTINCT customer)AS DATECUSTOMERS FROM
SaleTable GROUP BY Date)AS CustomerPerDate
