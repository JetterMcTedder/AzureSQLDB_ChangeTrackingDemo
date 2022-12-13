-- Update a row

-- Show initial data set

SELECT
    P.ProductID, P.Name, P.ListPrice
FROM
   SalesLT.Product AS P
order by 1;

-- #####

-- Update a value

update SalesLT.Product
   set ListPrice = 1431.60
 where ProductID = 680;

-- #####

-- Look at the change tracking info in the side table
-- CHANGETABLE takes in a table name and a version number
-- Side Table contains the primary key(s)

declare @last_synchronization_version bigint;

SELECT
    *
FROM
    CHANGETABLE(CHANGES SalesLT.Product, @last_synchronization_version) AS CT;

-- If the value is NULL (@last_synchronization_version), all tracked changes are returned

-- ####

-- CT Context

declare @var VARBINARY(100) = convert(varbinary,'Super Important Update');

WITH CHANGE_TRACKING_CONTEXT (@var)
update SalesLT.Product
   set ListPrice = 1431.60
 where ProductID = 706;

-- 

declare @last_synchronization_version bigint;

SELECT
     convert(VARCHAR(100),CT.SYS_CHANGE_CONTEXT) 'Converted Context',*
FROM
    CHANGETABLE(CHANGES SalesLT.Product, @last_synchronization_version) AS CT;