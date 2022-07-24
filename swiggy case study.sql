CREATE DATABASE swiggy;

/************TABLES CREATION**********************/

CREATE TABLE users(
	user_id INT(11) PRIMARY KEY,
	name char(255),
	email varchar(255),
	password varchar(255)
	)
CREATE TABLE restaurants(
    r_id INT(11) PRIMARY KEY,
    r_name VARCHAR(255),
    cuisine CHAR(255),
    rating FLOAT(25)
    )
CREATE TABLE food(
    f_id INT(11) PRIMARY KEY,
    f_name VARCHAR(78),
    type CHAR(15)
    )
CREATE TABLE menu(
    menu_id INT(11) PRIMARY KEY,
    FOREIGN KEY (r_id) REFERENCES restaurants(r_id),
    FOREIGN KEY (f_id) REFERENCES food(f_id),
    price INT(11)
    )
CREATE TABLE orders(
    order_id INT(11) PRIMARY KEY,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (r_id) REFERENCES restaurants(r_id),
    amount INT(11),
    orderdate date
    )
CREATE TABLE order_details(
	id INT(11) PRIMARY KEY,
	order_id INT(11),
	f_id INT(11),
	FOREIGN KEY (f_id) REFERENCES food(f_id),
	FOREIGN KEY (order_id) REFERENCES orders(order_id)
	)


/************************************************************************************************
Insert the data in the tables
************************************************************************************************/

INSERT INTO users VALUES
(1,'Yamini','yamini@abc.com','r5whs8'),
(2,'Shivani','shiv_ani@abc.com','4gaj7s'),
(3,'Nikita','niki12@abc.com','e34frt'),
(4,'Surbhi','surbhii@abc.com','rt45fg'),
(5,'Nivedita','nivi678@abc.com','cf4h4g'),
(6,'Ankit','ankitto@abc.com','er8fg8j'),
(7,'Kusha','kushaaa@abc.com','sdr3g6')

INSERT INTO restaurants VALUES
(1,'Kfc','American',3.9),
(2,'Box8','North Indian',4.3),
(3,'Dominos','Italian',4.1),
(4,'China Town','Chinese',4),
(5,'Dosa Plaza','South Indian',4.6)

INSERT INTO food VALUES
(1,'Non-veg Pizza','Non-veg'),
(2,'Veg Pizza','Veg'),
(3,'Choco Lava cake','Veg'),
(4,'Chicken Wings','Non-veg'),
(5,'Chicken Popcorn','Non-veg'),
(6,'Rice Meal','Veg'),
(7,'Roti meal','Veg'),
(8,'Masala Dosa','Veg'),
(9,'Rava Idli','Veg'),
(10,'Schezwan Noodles','Veg'),
(11,'Veg Manchurian','Veg')

INSERT INTO menu VALUES
(1,1,1,450),(2,1,2,400),(3,1,3,100),(4,2,3,115),
(5,2,4,230),(6,2,5,300),(7,3,3,80),(8,3,6,160),
(9,3,7,140),(10,4,6,230),(11,4,8,180),(12,4,9,120),
(13,5,6,250),(14,5,10,220),(15,5,11,180)

INSERT INTO orders VALUES
(1001,1,1,550,'2022-05-10'),(1002,1,2,415,'2022-05-26'),(1003,1,3,240,'2022-06-15'),
(1004,1,3,240,'2022-06-29'),(1005,1,3,220,'2022-07-10'),(1006,2,1,950,'2022-06-10'),
(1007,2,2,530,'2022-06-23'),(1008,2,3,240,'2022-07-07'),(1009,2,4,300,'2022-07-17'),
(1010,2,5,650,'2022-07-31'),(1011,3,1,450,'2022-05-10'),(1012,3,4,180,'2022-05-20'),
(1013,3,2,230,'2022-05-30'),(1014,3,2,230,'2022-06-11'),(1015,3,2,230,'2022-06-22'),
(1016,4,4,300,'2022-05-15'),(1017,4,4,300,'2022-05-30'),(1018,4,4,400,'2022-06-15'),
(1019,4,5,400,'2022-06-30'),(1020,4,5,400,'2022-07-15'),(1021,5,1,550,'2022-07-01'),
(1022,5,1,550,'2022-07-08'),(1023,5,2,645,'2022-07-15'),(1024,5,2,645,'2022-07-21'),
(1025,5,2,645,'2022-07-28') 

INSERT INTO order_details VALUES
(1,1001,1),(2,1001,3),(3,1002,4),(4,1002,3),
(5,1003,6),(6,1003,3),(7,1004,6),(8,1004,3),
(9,1005,7),(10,1005,3),(11,1006,1),(12,1006,2),
(13,1006,3),(14,1007,4),(15,1007,3),(16,1008,6),
(17,1008,3),(18,1009,8),(19,1009,9),(20,1010,10),
(21,1010,11),(22,1010,6),(23,1011,1),(24,1012,8),
(25,1013,4),(26,1014,4),(27,1015,4),(28,1016,8),
(29,1016,9),(30,1017,8),(31,1017,9),(32,1018,10),
(33,1018,11),(34,1019,10),(35,1019,11),(36,1020,10),
(37,1020,11),(38,1021,1),(39,1021,3),(40,1022,1),
(41,1022,3),(42,1023,3),(44,1023,5),(45,1024,3),
(46,1024,4),(47,1024,5),(48,1025,3),(49,1025,4),
(50,1025,5)

/***********************************************************************************************************/

/*********************************************QUESTIONS*************************************************/

--Q.1-->List out the name of users who never ordered.

SELECT name FROM users WHERE user_id NOT IN (SELECT user_id FROM orders)

--Q.2-->Avg Price/dish.

SELECT f.f_name,AVG(price) AS 'Avg Price'  
FROM menu m
JOIN food f 
ON m.f_id=f.f_id 
GROUP BY m.f_id


--Q.3-->Find top restaurant in terms of number of orders for the month of JUNE.

SELECT r.r_name,COUNT(*) AS 'month'
FROM orders o
JOIN restaurants r
ON o.r_id=r.r_id
WHERE MONTHNAME(orderdate) LIKE ('June')
GROUP BY o.r_id 
ORDER BY COUNT(*) DESC LIMIT 1


--Q.4-->Restaurants with monthly sales  > 25000.

SELECT r.r_name,SUM(amount) AS 'revenue' 
FROM orders o
JOIN restaurants r
ON o.r_id=r.r_id
WHERE MONTHNAME(orderdate) LIKE 'JUNE'
GROUP BY o.r_id
HAVING revenue>25000


--Q.5-->Show all orders with order details for a particular customer in a particular date range.
 
/* HERE We are considering USER-->Yamini */

SELECT o.order_id,r.r_name,od.f_id,f.f_name
FROM orders o
JOIN restaurants r
ON r.r_id = o.r_id
JOIN order_details od
ON o.order_id=od.order_id
JOIN food f
ON f.f_id=od.f_id
WHERE user_id=(SELECT user_id from users WHERE name LIKE 'Yamini')
AND (orderdate>='2022-06-19' AND orderdate<='2022-07-10') 


--Q.6-->Find Restaurants with max repeated customers.


SELECT r.r_name,COUNT(*) AS 'Loyal_Customers'
FROM(
     SELECT r_id,user_id,COUNT(*) AS 'Visits'
	 FROM orders 
	 GROUP BY r_id,user_id
	 HAVING Visits>1
     ) t
JOIN restaurants r
ON r.r_id=t.r_id
GROUP BY t.r_id
ORDER BY Loyal_Customers DESC LIMIT 1


--Q.7-->Month over Month revenue growath of swiggy(in percentage).

SELECT month,((Revenue-prev)/prev)*100 FROM (
	WITH sales AS /*due to this our month,revenue table stored in memory*/
	(
        SELECT MONTHNAME(orderdate) AS 'month',SUM(amount) AS 'Revenue'
        FROM orders
        GROUP BY month
        ORDER BY MONTH(orderdate) /*it gives month number */
    )
SELECT month,revenue,LAG(Revenue,1) OVER(ORDER BY Revenue) AS prev FROM sales
) t

--Q.8-->List out the Customers with their Name and Favorite Food.

WITH temp AS (
    SELECT o.user_id,od.f_id,COUNT(*) AS 'Frequency'
    FROM orders o
    JOIN order_details od
    ON o.order_id=od.order_id
    GROUP BY o.user_id,od.f_id
    )
    
SELECT u.name,f.f_name,t1.frequency
FROM temp t1
JOIN users u
ON u.user_id=t1.user_id
JOIN food f
ON f.f_id=t1.f_id
WHERE t1.Frequency=(
    SELECT MAX(Frequency) 
    FROM temp t2 
    WHERE t2.user_id=t1.user_id) 
	


















	
	


    

   