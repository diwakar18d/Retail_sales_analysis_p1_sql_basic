# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `sql_p1`

This project aims to showcase SQL competencies and techniques frequently utilized by data analysts to examine, cleanse, and interpret retail sales data. The project involves establishing a retail sales database, conducting exploratory data analysis (EDA), and resolving specific business queries through SQL statements. This project is particularly suitable for beginners looking to establish a strong foundation in SQL.

## Objectives

1. **Database Initialization**: Establish and populate a retail sales database with the provided sales data.
2. **Data Cleansing**: Detect and eliminate any records containing missing or null values.
3. **Exploratory Data Analysis (EDA)**: Conduct basic exploratory analysis to gain insights into the dataset.
4. **Business Query Resolution**: Utilize SQL to address specific business queries and extract valuable insights from the sales data.


## Project Structure

### 1. Database Setup

- **Database Creation**: The project begins by creating a database named `sql_p1`.
- **Table Creation**: A table named `retail_sales` is established to store the sales data. The table includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE sql_p1;

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
```

### 2. Data Exploration & Cleaning

- **Record Count**: Ascertain the total number of records within the dataset.
- **Customer Count**: Determine the number of unique customers present in the dataset.
- **Category Count**: Identify all distinct product categories within the dataset.
- **Missing Data**: Identify and remove records with missing or null values to ensure the dataset is clean.
- **Basic Descriptive Statistics**: Compute basic descriptive statistics such as average quantity sold, average price, and total sales per category.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

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


```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql

select * from retail_sales where sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql

select * from retail_sales 
where category = 'Clothing'
and quantiy >= 4
and TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
select 
	Category,
	sum(total_sale) as NETSALES,
	count(*) as total_sales
from retail_sales
group by category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
select 
Round(Avg(age),2) as AVG_Age_Under_beauty
from retail_sales
where Category ='Beauty';
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
select * from retail_sales 
where total_sale > 1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
select 
category,
gender,
count(transactions_id) as Transactions
from retail_sales
group by category,gender
order by 1;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
select 
	customer_id,
	SUM(total_sale) as totalsales
from retail_sales
group by 1
order by 2 desc limit 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
select 
category,
COUNT(DISTINCT customer_id) as unique_cs
from retail_sales
group by 1;

```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
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
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A comprehensive report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across various months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project provides a thorough introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-oriented SQL queries. The insights derived from this project can inform business decisions by revealing sales trends, customer behavior, and product performance.


## Author - Diwakar Kumar

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, feel free to get in touch!

### Stay Updated and Join the Community

For more content on SQL, data analysis, and other data-related topics, make sure to connect with me on LinkedIn :

- **LinkedIn**: [Connect with me professionally](https://www.linkedin.com/in/diwakar-1-kumar)

I look forward to connecting with you!
