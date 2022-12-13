-- Multiple transactions and version numbers

-- Multiple transactions; one at a time

update SalesLT.Product
   set ListPrice = 34.89
 where ProductID = 711;

 update SalesLT.Product
   set ListPrice = 8.89
 where ProductID = 712;

--

declare @last_synchronization_version bigint;

SELECT
    *
FROM
    CHANGETABLE(CHANGES SalesLT.Product, @last_synchronization_version) AS CT
order by 1;


-- multiple rows in a single statement

update SalesLT.Product
   set ListPrice = 50.00
 where ListPrice = 49.99;

--
declare @last_synchronization_version bigint;

SELECT
    *
FROM
    CHANGETABLE(CHANGES SalesLT.Product, @last_synchronization_version) AS CT
order by 1;
--
-- multiple transactions in a single commit

--
BEGIN TRANSACTION;  

update SalesLT.Product
   set ListPrice = 8.00
 where ProductID = 709;

 update SalesLT.Product
   set ListPrice = 8.00
 where ProductID = 710;

COMMIT;  
--
declare @last_synchronization_version bigint;

SELECT
    *
FROM
    CHANGETABLE(CHANGES SalesLT.Product, @last_synchronization_version) AS CT
order by 1;

--

SELECT
    *
FROM
    CHANGETABLE(CHANGES SalesLT.Product, 0) AS CT
order by 1;

SELECT
    *
FROM
    CHANGETABLE(CHANGES SalesLT.Product, 1) AS CT
order by 1;

SELECT
    *
FROM
    CHANGETABLE(CHANGES SalesLT.Product, 6) AS CT
order by 1;

-- #####