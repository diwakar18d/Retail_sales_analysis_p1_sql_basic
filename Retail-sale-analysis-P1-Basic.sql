--Sql  retail sales analysis

Create table retail_sales 
		(
		transactions_id	INT PRIMARY KEY,
		sale_date	DATE,
		sale_time	TIME,
		customer_id	INT,
		gender	VARCHAR(10),
		age	INT,
		category VARCHAR(15),	
		quantiy	INT,
		price_per_unit	FLOAT,
		cogs	FLOAT,
		total_sale FLOAT
		);

select * from retail_sales
LIMIT 10;

-- DATA CLEANING

select count(*) from retail_sales;

select * from retail_sales
where transactions_id IS NULL;

select * from retail_sales
where transactions_id IS NULL;

select * from retail_sales
where transactions_id IS NULL
	OR	sale_date IS NULL
	OR	sale_time IS NULL
	OR	customer_id	IS NULL
	OR	gender	IS NULL
	OR	age	IS NULL
	OR	category IS NULL	
	OR	quantiy	IS NULL
	OR	price_per_unit	IS NULL
	OR	cogs	IS NULL
	OR	total_sale IS NULL;

DELETE FROM retail_sales
where transactions_id IS NULL
	OR	sale_date IS NULL
	OR	sale_time IS NULL
	OR	customer_id	IS NULL
	OR	gender	IS NULL
	OR	age	IS NULL
	OR	category IS NULL	
	OR	quantiy	IS NULL
	OR	price_per_unit	IS NULL
	OR	cogs	IS NULL
	OR	total_sale IS NULL;

--DATA EXPLORATION
-- HOW MANY SALES WE HAVE?

select count(*) AS TOTAL_SALES from retail_sales;

--HOW MANY UNIQUE CUSTOMER WE HAVE?
SELECT COUNT(DISTINCT customer_id)
from retail_sales;


SELECT DISTINCT CATEGORY
from retail_sales;

--DATA ANALYSIS & BUSINESS KEY PROBLEMS
-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

select * from retail_sales where sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than or equal to 4 in the month of Nov-2022

select * from retail_sales 
where category = 'Clothing'
and quantiy >= 4
and TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select 
	Category,
	sum(total_sale) as NETSALES,
	count(*) as total_sales
from retail_sales
group by category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select 
Round(Avg(age),2) as AVG_Age_Under_beauty
from retail_sales
where Category ='Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.


select * from retail_sales 
where total_sale > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select 
category,
gender,
count(transactions_id) as Transactions
from retail_sales
group by category,gender
order by 1;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year


SELECT 
   year,
   month,
   avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,  -- YEAR(sale_date) for sql
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1
    
-- ORDER BY 1, 3 DESC

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select 
	customer_id,
	SUM(total_sale) as totalsales
from retail_sales
group by 1
order by 2 desc limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.


select 
category,
COUNT(DISTINCT customer_id) as unique_cs
from retail_sales
group by 1;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift
Order by 2 desc;

-- End of project
