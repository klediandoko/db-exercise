
/* Customer with the most orders */
SELECT c.customerNumber, c.customerName, COUNT(o.orderNumber)  orderCount
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY c.customerNumber, c.customerName
HAVING COUNT(o.orderNumber) = (
    SELECT MAX(orderCount)
    FROM (
        SELECT COUNT(o.orderNumber) orderCount
        FROM orders o
        GROUP BY o.customerNumber
    ) AS orderCounts
)
ORDER BY orderCount DESC;


/* All Germany customers and their order details. */
select cs.customerNumber, cs.customerName, cs.country, cs.salesRepEmployeeNumber, o.orderNumber, o.orderDate, o.requiredDate, o.shippedDate,
o.status, od.productCode, od.quantityOrdered, od.priceEach, od.orderLineNumber  from customers cs
left join orders o on cs.customerNumber = o.customerNumber
inner join orderdetails od on o.orderNumber = od.orderNumber
where cs.country = 'Germany'
order by cs.customerNumber;


/* List all employees and their revenue */
select em.employeeNumber, em.lastName, em.firstName, ifnull(sum(pm.amount), 0) revenue from employees em 
left join customers cm on em.employeeNumber = cm.salesRepEmployeeNumber
left join payments pm on cm.customerNumber = pm.customerNumber
group by em.employeeNumber
order by em.employeeNumber asc;

/*All products which have been ordered last month*/
select pr.productCode, pr.productName, pr.productDescription, o.orderDate from products pr
inner join orderdetails od on pr.productCode = od.productCode
inner join orders o on od.orderNumber = o.orderNumber
where o.orderDate between '2004-12-01' and '2004-12-31';


/* Create customerdetails table */
USE `classicmodels`;
DROP TABLE IF EXISTS `employeeDetails`;

CREATE TABLE `employeeDetails`(
	`bankAccount` varchar(50) NOT NULL,
    `address` varchar(50) NOT NULL,
    `phoneNumber` varchar(50) NOT NULL,
    `personalEmail` varchar(50) NOT NULL,
    `employeeNumber`int(11) NOT NULL primary key,
    
    constraint `employees_ibfk_3`foreign key (employeeNumber) references employees(employeeNumber)
); 