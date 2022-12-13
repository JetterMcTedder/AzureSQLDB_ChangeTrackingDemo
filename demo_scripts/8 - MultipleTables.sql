-- Multiple tables/multiple transactions

BEGIN TRANSACTION;  

update SalesLT.Product
   set ListPrice = 8.01
 where ProductID = 709;

 update SalesLT.Product
   set ListPrice = 8.01
 where ProductID = 712;

update SalesLT.Customer
set MiddleName = N'A.'
where CustomerID = 2;

COMMIT;  

select object_name(object_id) [table],* from sys.change_tracking_tables;

select CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID('SalesLT.Product'));

select CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID('SalesLT.Customer'));

SELECT
    *
FROM
    CHANGETABLE(CHANGES SalesLT.Product, 0) AS CT;

SELECT
    *
FROM
    CHANGETABLE(CHANGES SalesLT.Customer, 0) AS CT;

