/* Exercise 6-45 */
SELECT  customer_t.customerid
      , customer_t.customername
	  , customer_t.customeraddress
	  , customer_t.customercity
	  , customer_t.customerstate
	  , customer_t.customerpostalcode

FROM project_00.customer_t

FULL JOIN project_00.order_t
       ON customer_t.customerid = order_t.customerid

WHERE order_t.orderid IS NULL

ORDER BY customer_t.customerid ASC 

;

/* Exercise 6-47 */
SELECT productlinename
	 , COUNT(*)
	 , cast( AVG(productstandardprice) as numeric(6,2)) as "productaverageprice"
	 
FROM project_00.productline_t
  
JOIN project_00.product_t
       ON productline_t.productlineid = product_t.productlineid  

GROUP BY productlinename
HAVING AVG(productstandardprice) > 200
;

/* Exercise 6-52 */
SELECT workcenter_t.workcenterid
     , workcenterlocation
	 , SUM(	case
		    	when employee_t.employeeid is null then 0
	     		else 1
	   		end)
       as "employeecount"

	 
FROM project_00.workcenter_t

FULL JOIN project_00.worksin_t
       ON workcenter_t.workcenterid = worksin_t.workcenterid


LEFT JOIN project_00.employee_t
       ON worksin_t.employeeid = employee_t.employeeid
	  

GROUP BY workcenter_t.workcenterid
       , workcenterlocation
;

/* Exercise 6-53 
Couldn't find QC1, used BS12 instead. RT1 is the other choice I find*/
SELECT DISTINCT workcenter_t.workcenterid
     , workcenterlocation
	 , skillid
	 
FROM project_00.workcenter_t

JOIN project_00.worksin_t
  ON workcenter_t.workcenterid = worksin_t.workcenterid

JOIN project_00.employeeskills_t
  ON worksin_t.employeeid = employeeskills_t.employeeid
 AND skillid = 'BS12'

;

/* Exercise 6-59 
Altered dates and prpduct line to match DB records*/
SELECT DISTINCT 
       customer_t.customerid
     , customername
	 , customeraddress
	 , customercity
	 , customerstate
	 , customerpostalcode
	 /*
	 , order_t.orderid
	 , orderdate
     , orderline_t.productid
	 , orderedquantity
	 , product_t.productlineid
	 , productdescription
	 , productfinish
	 , productstandardprice
	 , productlinename
	 , EXTRACT(YEAR FROM orderdate) 
     , EXTRACT(MONTH FROM orderdate)
	 */
FROM project_00.customer_t

JOIN project_00.order_t
  ON customer_t.customerid = order_t.customerid

JOIN project_00.orderline_t
  ON order_t.orderid = orderline_t.orderid
 AND EXTRACT(YEAR FROM orderdate) = 2018
 AND EXTRACT(MONTH FROM orderdate) = 10

JOIN project_00.product_t
  ON orderline_t.productid = product_t.productid 

JOIN project_00.productline_t
  ON product_t.productlineid =  productline_t.productlineid
 AND productlinename = 'Country Look'
 
;

/* Exercise 6-62 */
SELECT DISTINCT
       employee_parent.employeeid
     , employee_parent.employeename
	 /*
	 , employee_parent.employeeaddress
	 , employee_parent.employeebirthdate
	 , employee_parent.employeecity
	 , employee_parent.employeestate
	 , employee_parent.employeezipcode
	 , employee_parent.employeedatehired
	 , employee_parent.employeesupervisor
     , employee_child.employeeid
     , employee_child.employeename
     */
FROM project_00.employee_t AS employee_parent

JOIN project_00.employee_t AS employee_child
  ON employee_child.employeeid = employee_parent.employeesupervisor

JOIN project_00.employeeskills_t
  ON employeeskills_t.employeeid = employee_child.employeeid

JOIN  project_00.skill_t
  ON  skill_t.skillid = employeeskills_t.skillid 
 AND skill_t.skillid = 'BS12'
  
ORDER BY employee_parent.employeename ASC
	
;

/* Exercise 6-68 */
/* Start with a count of all products ordered 
Then full join all products
Then handle nulls
*/

SELECT orderline_t.productid
	 , product_t.productdescription
	 , SUM(orderedquantity)
	 , SUM(	case
		    	when orderedquantity is null then 0
	     		else orderedquantity
	   		end)
       as "orderedquantity"
	 
FROM project_00.orderline_t

FULL JOIN project_00.product_t
       ON product_t.productid = orderline_t.productid

GROUP BY orderline_t.productid
       , product_t.productdescription
;

/* Venn Diagram
+---------------------------+
|                           |
|  All products in          |
|  product_t                |
|                           |
+     +---------------------+----+
|     |                     |    |
|     | Ordered products in |    |
|     | orderline_t         |    |
|     |                     |    |
+-----+---------------------+    |
      |                          |
      | Vaporware caused by      | 
      | salesman's dreams        |
      |                          |
      +--------------------------+