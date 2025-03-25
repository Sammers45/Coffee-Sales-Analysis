-- CREATING TABLE : 

DROP TABLE IF EXISTS coffee_sales;

CREATE TABLE coffee_sales(
transaction_id INT,
transaction_date DATE,
transaction_time TIME,
transaction_qty INT,
store_id INT,
store_location VARCHAR(100),
product_id INT,
unit_price FLOAT,
product_category VARCHAR(100),
product_type VARCHAR(100),
product_detail VARCHAR(100)
);


SELECT * FROM coffee_sales ;

-- PROBLEM STATEMENT SOLUTION : 

-- 1) TOTTAL SALES FROM ALL THE MONTHS : 

SELECT 
	EXTRACT(MONTH FROM transaction_date) AS Month,
	ROUND (SUM(transaction_qty * unit_price)::INT,2) AS Total_sales
FROM 
	coffee_sales
GROUP BY 1
ORDER BY 1;

-- 2) Calculate difference in sales between the selected month and the previous month : 

SELECT 
	month_no ,
	Total_Sales,
	previous_month_sale,
	Diff_In_Sales,
	CASE
	WHEN  Diff_In_Sales > 0 THEN 'SALE INC'
	WHEN  Diff_In_Sales < 0 THEN 'SALE DEC'
	WHEN  Diff_In_Sales = 0 THEN 'SALE SAME'
	ELSE 'NAN'
	END AS MOM_INC_DEC,
	ROUND((Diff_In_Sales::INT/previous_month_sale)*100,2) AS Sale_inc_dec_percentage
FROM
(
SELECT 
	EXTRACT(MONTH FROM transaction_date) AS month_no ,
	ROUND(SUM(transaction_qty*unit_price):: INT,2) AS Total_Sales,
	LAG(ROUND(SUM(transaction_qty*unit_price):: INT,2)) OVER(ORDER BY EXTRACT(MONTH FROM transaction_date)) AS previous_month_sale,
	(ROUND(SUM(transaction_qty*unit_price):: INT,2) - LAG(ROUND(SUM(transaction_qty*unit_price):: INT,2)) OVER(ORDER BY EXTRACT(MONTH FROM transaction_date))) AS Diff_In_Sales
FROM 
	coffee_sales
GROUP BY 1
ORDER BY 1)
WHERE month_no = 5
;

-- 3) Determine Month on Month Inc or Dec In Sales : 

SELECT 
	month_no ,
	Total_Sales,
	previous_month_sale,
	Diff_In_Sales,
	CASE
	WHEN (Total_Sales - LAG(Total_Sales) OVER(ORDER BY month_no)) > 0 THEN 'SALE INC'
	WHEN  (Total_Sales - LAG(Total_Sales) OVER(ORDER BY month_no)) < 0 THEN 'SALE DEC'
	WHEN  (Total_Sales - LAG(Total_Sales) OVER(ORDER BY month_no)) = 0 THEN 'SALE SAME'
	ELSE 'NAN'
	END AS MOM_INC_DEC,
	ROUND((Diff_In_Sales::INT/previous_month_sale)*100,2) AS Sale_inc_dec_percentage
FROM
(
SELECT 
	EXTRACT(MONTH FROM transaction_date) AS month_no ,
	LAG(ROUND(SUM(transaction_qty*unit_price):: INT,2)) OVER(ORDER BY EXTRACT(MONTH FROM transaction_date)) AS previous_month_sale,
	(ROUND(SUM(transaction_qty*unit_price):: INT,2) - LAG(ROUND(SUM(transaction_qty*unit_price):: INT,2)) OVER(ORDER BY EXTRACT(MONTH FROM transaction_date))) AS Diff_In_Sales,
	ROUND(SUM(transaction_qty*unit_price):: INT,2) AS Total_Sales
FROM 
	coffee_sales
GROUP BY 1
ORDER BY 1)
;

-- 4) Calculate Total Number Of Orders For the each respective Month : 

SELECT 
	EXTRACT(MONTH FROM transaction_date) AS Month,
	COUNT(transaction_id) AS Total_Orders
FROM 
	coffee_sales
GROUP BY 1
ORDER BY 1;

-- 5) Determine Month_on_Month INC or DEC in the number of orders : 

SELECT
	month_no,
	Total_orders,
	previous_month_orders,
	Diff_no_of_orders,
	CASE 
	WHEN Diff_no_of_orders > 0 THEN 'NO OF ORDERS INC'
	WHEN Diff_no_of_orders < 0 THEN 'NO OF ORDERS DEC'
	WHEN Diff_no_of_orders = 0 THEN 'NO OF ORDERS SAME'
	ELSE 'NAN'
	END AS mom_inc_dec
FROM
(SELECT 
	EXTRACT(MONTH FROM transaction_date) AS month_no,
	COUNT(transaction_id) AS Total_Orders,
	LAG(COUNT(transaction_id)) OVER(ORDER BY EXTRACT(MONTH FROM transaction_date)) AS previous_month_orders,
	COUNT(transaction_id) - LAG(COUNT(transaction_id)) OVER(ORDER BY EXTRACT(MONTH FROM transaction_date)) AS Diff_no_of_orders
FROM 
	coffee_sales
GROUP BY 1
ORDER BY 1)
;

-- 6) Calculate the difference in no of orders between the selected month and the previous month : 

SELECT
	month_no,
	Total_orders,
	previous_month_orders,
	Diff_no_of_orders,
	CASE 
	WHEN Diff_no_of_orders > 0 THEN 'NO OF ORDERS INC'
	WHEN Diff_no_of_orders < 0 THEN 'NO OF ORDERS DEC'
	WHEN Diff_no_of_orders = 0 THEN 'NO OF ORDERS SAME'
	ELSE 'NAN'
	END AS mom_inc_dec
FROM
(SELECT 
	EXTRACT(MONTH FROM transaction_date) AS month_no,
	COUNT(transaction_id) AS Total_Orders,
	LAG(COUNT(transaction_id)) OVER(ORDER BY EXTRACT(MONTH FROM transaction_date)) AS previous_month_orders,
	COUNT(transaction_id) - LAG(COUNT(transaction_id)) OVER(ORDER BY EXTRACT(MONTH FROM transaction_date)) AS Diff_no_of_orders
FROM 
	coffee_sales
GROUP BY 1
ORDER BY 1)
WHERE month_no = 5
;

-- 7) Calculate the total quantity sold for each respective month : 

SELECT 
	EXTRACT(MONTH FROM transaction_date) AS Month,
	SUM(transaction_qty) AS Total_quantity_sold
FROM 
	coffee_sales
GROUP BY 1
ORDER BY 1;

-- 8) Determine Month_on_Month INC or DEC in the total quantity sold : 

SELECT
	month_no,
	Total_quantity_sold,
	previous_quantity_sold,
	Diff_no_of_quantity_sold,
	CASE 
	WHEN Diff_no_of_quantity_sold > 0 THEN 'NO OF QUANTITY SOLD INC'
	WHEN Diff_no_of_quantity_sold < 0 THEN 'NO OF QUANTITY SOLD DEC'
	WHEN Diff_no_of_quantity_sold = 0 THEN 'NO OF QUANTITY SOLD SAME'
	ELSE 'NAN'
	END AS mom_inc_dec
FROM
(SELECT 
	EXTRACT(MONTH FROM transaction_date) AS month_no,
	SUM(transaction_qty) AS Total_quantity_sold,
	LAG(SUM(transaction_qty)) OVER(ORDER BY EXTRACT(MONTH FROM transaction_date)) AS previous_quantity_sold,
	SUM(transaction_qty) - LAG(SUM(transaction_qty)) OVER(ORDER BY EXTRACT(MONTH FROM transaction_date)) AS Diff_no_of_quantity_sold
FROM 
	coffee_sales
GROUP BY 1
ORDER BY 1)
;

-- 9) Calculate the difference in no of quantity sold between the selected month and the previous month : 

SELECT
	month_no,
	Total_quantity_sold,
	previous_quantity_sold,
	Diff_no_of_quantity_sold,
	CASE 
	WHEN Diff_no_of_quantity_sold > 0 THEN 'NO OF QUANTITY SOLD INC'
	WHEN Diff_no_of_quantity_sold < 0 THEN 'NO OF QUANTITY SOLD DEC'
	WHEN Diff_no_of_quantity_sold = 0 THEN 'NO OF QUANTITY SOLD SAME'
	ELSE 'NAN'
	END AS mom_inc_dec
FROM
(SELECT 
	EXTRACT(MONTH FROM transaction_date) AS month_no,
	SUM(transaction_qty) AS Total_quantity_sold,
	LAG(SUM(transaction_qty)) OVER(ORDER BY EXTRACT(MONTH FROM transaction_date)) AS previous_quantity_sold,
	SUM(transaction_qty) - LAG(SUM(transaction_qty)) OVER(ORDER BY EXTRACT(MONTH FROM transaction_date)) AS Diff_no_of_quantity_sold
FROM 
	coffee_sales
GROUP BY 1
ORDER BY 1)
WHERE month_no = 5
;

-- 10) Determine the total sales , total orders and total quantity sold on the specific day of specific month : 

SELECT
	EXTRACT(DAY FROM transaction_date) AS date,
	ROUND(SUM(transaction_qty::INT*unit_price::INT),2) AS total_sales,
	COUNT(transaction_id) AS total_orders,
	SUM(transaction_qty) AS total_quantity_sold
FROM
	coffee_sales
WHERE EXTRACT(MONTH FROM transaction_date) = 5
GROUP BY 1
ORDER BY 1
;

-- 11) Sales Analysis By weekdays and weekends : HERE WEEKEND AS -> SAT AND SUN , WEEKDAYS -> REST OF THE DAYS
--SUN - 0
--MON - 1
-- .
-- .
-- SAT - 6


SELECT 
	week_day ,
	ROUND(SUM(transaction_qty::INT*unit_price::INT),2) AS total_sales,
	COUNT(transaction_id) AS total_orders,
	SUM(transaction_qty) AS total_quantity_sold
FROM 
(
SELECT 
	* ,
	CASE 
	WHEN EXTRACT(DOW FROM transaction_date) = 0 OR EXTRACT(DOW FROM transaction_date) = 6 THEN 'WEEKEND'
	ELSE 'WEEKDAY'
	END AS week_day
FROM
 coffee_sales
)
GROUP BY 1
ORDER BY 2 DESC;

-- 12) Sales Analysis By store Location : 

SELECT 
	store_location ,
	ROUND(SUM(transaction_qty::INT*unit_price::INT),2) AS total_sales,
	COUNT(transaction_id) AS total_orders,
	SUM(transaction_qty) AS total_quantity_sold
FROM 
	coffee_sales
GROUP BY 1
ORDER BY 2 DESC;

-- 13) Average Sale for the specific month : 

SELECT 
	AVG(Total_sales) AS avg_monthly_sale
FROM
(
SELECT 
	SUM(transaction_qty*unit_price) AS Total_sales
FROM 
	coffee_sales
WHERE 
	EXTRACT(MONTH FROM transaction_date) = 5
GROUP BY transaction_date
);
	

-- 14) COMPARING MONTHLY SALES WITH AVERAGE MONTHLY SALES – IF GREATER THAN “ABOVE AVERAGE” and LESSER THAN “BELOW AVERAGE” : 

SELECT 
	month_no,
	total_sales,
	 AVG(SUM(total_sales)) OVER() AS monthly_avg_sales,
	CASE 
	WHEN total_sales > AVG(SUM(total_sales)) OVER() THEN 'ABOVE AVERAGE'
	WHEN total_sales < AVG(SUM(total_sales)) OVER() THEN 'BELOW AVERAGE'
	ELSE 'SAME AS AVERAGE'
	END AS sales_status
FROM
(
SELECT  
	EXTRACT(MONTH FROM transaction_date) AS month_no,
	ROUND(SUM(transaction_qty::INT*unit_price::INT),2) AS total_sales
FROM 
	coffee_sales
GROUP BY 1
ORDER BY 1
)
GROUP BY 1,2
ORDER BY 1;

-- 15) COMPARING DAILY SALES WITH AVERAGE DAILY SALES(of specific month) – IF GREATER THAN “ABOVE AVERAGE” and LESSER THAN “BELOW AVERAGE” FOR THE SPECIFIC MONTH :

SELECT 
	date,
	total_sales,
	 AVG(SUM(total_sales)) OVER() AS monthly_avg_sales,
	CASE 
	WHEN total_sales > AVG(SUM(total_sales)) OVER() THEN 'ABOVE AVERAGE'
	WHEN total_sales < AVG(SUM(total_sales)) OVER() THEN 'BELOW AVERAGE'
	ELSE 'SAME AS AVERAGE'
	END AS sales_status
FROM
(
SELECT  
	EXTRACT(DAY FROM transaction_date) AS date,
	ROUND(SUM(transaction_qty::INT*unit_price::INT),2) AS total_sales
FROM 
	coffee_sales
WHERE EXTRACT(MONTH FROM transaction_date) = 5
GROUP BY 1
ORDER BY 1
)
GROUP BY 1,2
ORDER BY 1;

-- 16) Sales Analysis By Product Category : 

SELECT 
	product_category ,
	ROUND(SUM(transaction_qty::INT*unit_price::INT),2) AS total_sales,
	COUNT(transaction_id) AS total_orders,
	SUM(transaction_qty) AS total_quantity_sold
FROM 
	coffee_sales
GROUP BY 1
ORDER BY 2 DESC;

-- 17) Query out top 10 product by sales : 

-- Method 1 : 

SELECT 
	product_type ,
	ROUND(SUM(transaction_qty::INT*unit_price::INT),2) AS total_sales,
	COUNT(transaction_id) AS total_orders,
	SUM(transaction_qty) AS total_quantity_sold
FROM 
	coffee_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

-- Method 2 :

SELECT 
	*,
	DENSE_RANK() OVER(ORDER BY total_sales DESC) AS sales_rank
FROM 
(
SELECT 
	product_type ,
	ROUND(SUM(transaction_qty::INT*unit_price::INT),2) AS total_sales,
	COUNT(transaction_id) AS total_orders,
	SUM(transaction_qty) AS total_quantity_sold
FROM 
	coffee_sales
GROUP BY 1
)
LIMIT 10;

-- 18) Sales Analysis By Specific month , specific Days and specific Hours :    


SELECT 
    ROUND(SUM(unit_price * transaction_qty)) AS Total_Sales,
	COUNT(transaction_id) AS Total_Orders,
    SUM(transaction_qty) AS Total_Quantity_sold
FROM 
    coffee_sales
WHERE 
    EXTRACT(DOW FROM transaction_date) = 3 
    AND EXTRACT(HOUR FROM transaction_time) = 8
    AND EXTRACT(MONTH FROM transaction_date) = 5; 

-- 19) query out sales from monday to sunday for the specific month or the overall data :

SELECT 
   	TO_CHAR(transaction_date, 'Day') AS day_of_week,
    ROUND(SUM(transaction_qty::INT * unit_price::INT), 2) AS total_sales,
    COUNT(transaction_id) AS total_orders,
    SUM(transaction_qty) AS total_quantity_sold
FROM 
    coffee_sales
GROUP BY 1
ORDER BY 2 DESC ;

--20) query out total sales of every hour of the whole month or the overall data : 

SELECT 
	EXTRACT(HOUR FROM transaction_time) AS hour_mark,
	ROUND(SUM(transaction_qty::INT*unit_price::INT),2) AS total_sales,
	COUNT(transaction_id) AS total_orders,
	SUM(transaction_qty) AS total_quantity_sold
FROM 
	coffee_sales
GROUP BY 1
ORDER BY 1;