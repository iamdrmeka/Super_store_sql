USE nimrodnewdb;
/*selecting and revieing all data*/
SELECT * FROM superstore_project;


 /*GETTING SALES BY STATES*/
USE nimrodnewdb;
SELECT state, round(sum(sales), 2) AS SALES
from superstore_project
group by state
ORDER BY Sales desc;

/*GETTING SALES BY CATEGORIES*/
use nimrodnewdb;
SELECT Category,
 round(sum(sales), 2) AS SALES,
 round(SUM(profit), 2) as PROFIT
 FROM superstore_project
 GROUP BY Category
 ORDER BY sales desc;

 /*order by products*/
 SELECT Category, product_name,
 round(sum(sales), 2) AS SALES,
 round(SUM(profit), 2) as PROFIT
 FROM superstore_project
 GROUP BY product_name, category
 ORDER BY sales desc;

 /*GETTING TOP 10 LOSSES by product and category*/
 USE nimrodnewdb;
 SELECT Category, product_name,
 round(sum(sales), 2) AS SALES,
 round(SUM(profit), 2) as PROFIT
 FROM superstore_project
 where profit < 0
 GROUP BY product_name, category
 ORDER BY profit asc
 limit 10;

 /*GETTING TOP 10 MOST PROFITABLE PRODUCTS*/
  USE nimrodnewdb;
 SELECT Category, product_name,
 round(sum(sales), 2) AS SALES,
 round(SUM(profit), 2) as PROFIT
 FROM superstore_project
 GROUP BY product_name, category
 ORDER BY profit DESC
 limit 10;

 /*SALES AND PROFIT BY STATES*/
 USE nimrodnewdb;
 select 
 state, 
 FORMAT(sum(profit), 2) AS PROFIT, /*FORMAT returns the numbers with coma saperators, but sql reads it as a string, so you have to order by the main value, see below*/
 FORMAT(sum(sales), 2) AS SALES_VOLUME
 FROM superstore_project
 GROUP BY state
 order by sum(profit) desc;








/*calling the mothly sales by Years and Month*/
use nimrodnewdb;
SELECT YEARLY_SALES, MONTHLY_SALES, PROFIT
FROM (
SELECT 
  YEAR(order_date) AS YEARLY_SALES,
  MONTH(order_date) AS MONTH_NUMBER,
   DATE_FORMAT(order_date, '%b') AS MONTHLY_SALES,
    format(sum(PROFIT), 2) as PROFIT
FROM superstore_project
group by yearly_sales, MONTH_NUMBER, MONTHLY_SALES
order by yearly_sales asc
) AS SORTED
ORDER BY YEARLY_SALES, MONTH_NUMBER

/*MONTHLY PORFOMANCE ACCROSS THE YEARS*/
SELECT 
Month_sold, sales, average_sales_monthly
FROM (
select DATE_FORMAT(order_date, '%b') AS MONTH_SOLD,
 format(SUM(sales), 2) AS SALES, 
FORMAT(sum(sales) / 4, 2) AS AVERAGE_SALES_monthly,
 MONTH(order_date) AS MONTH_NUMBER
from superstore_project
group by month_number, Month_sold
ORDER BY sum(sales) desc
) AS AVERAGE

/*calling for Yearly sales and profit*/

USE nimrodnewdb;
select 
Year(order_date) AS YEAR_SOLD,
 FORMAT(SUM(sales), 2) AS SALES_VOLUME,
       FORMAT(SUM(profit), 2) AS PROFIT
             
    from superstore_project
    GROUP BY YEAR_SOLD
    ORDER BY YEAR_SOLD

/*TOP 10 MOST PROFITABLE PRODUCTS*/

use nimrodnewdb;
SELECT product_name,
       FORMAT(sum(profit), 2) AS PROFIT
    FROM superstore_project
GROUP BY product_name
ORDER BY SUM(PROFIT) DESC
limit 10;

/*LAST 10 PROFITABLE PRODUCTS*/
use nimrodnewdb;
SELECT product_name,
       FORMAT(sum(profit), 2) AS PROFIT
    FROM superstore_project
    where profit > 0
GROUP BY product_name
ORDER BY SUM(PROFIT) ASC
LIMIT 10;

/*NUMBER OF PRODUCTS BEING ANALYSED*/
USE nimrodnewdb;
SELECT COUNT(DISTINCT product_name)
FROM superstore_project;

/* COUNT PRODUCTS THAT RECORDED LOSSES*/
USE nimrodnewdb;

SELECT COUNT(*) AS "PRODUCTS MAKING LOSSES"
FROM (
SELECT product_name
from superstore_project
GROUP BY product_name
HAVING SUM(profit) < 0
) AS LOSSES;

/*PRODUCTS THAT RECORDED LOSSES*/
SELECT product_name, 
		FORMAT(SUM(profit), 2) AS Profit_made
FROM superstore_project
GROUP BY product_name
HAVING sum(profit) < 0 
ORDER BY sum(profit);

/*CHECKING IF PRODUCTS THAT HAD NO DISCOUNT HAS LOSSES*/
select *
from superstore_project
where Discount = 0 AND  profit < 0 /*NO LOSSES*/


/*HIGHEST 10 SALES BY  PRODUCTS*/

SELECT product_name,
	FORMAT(sum(sales), 2) AS SALES_VOLUME
FROM superstore_project
GROUP BY product_name
ORDER BY SUM(SALES) DESC
LIMIT 10;




/*GROUP SALES BY REGION*/
SELECT region, FORMAT(sum(sales), 2) AS SALES
from superstore_project
GROUP BY region
order by sum(sales);

/*count number of customers*/
USE nimrodnewdb;
SELECT COUNT(DISTINCT customer_id)
FROM superstore_project;

/*TOP 5 CUSTOMERS */
select customer_name, format(sum(sales), 2) AS ORDER_VOLUME
from superstore_project
group by customer_name
order by sum(sales) desc
limit 5;



