-- ETL Use Case

-- versions are stored in the application or where the ETL process is so that 
-- the current version can be tracked and we dont pull old changes.

declare @last_synchronization_version bigint = 0;

SELECT
    CT.ProductID, P.Name, P.ListPrice, CT.SYS_CHANGE_VERSION,
    CT.SYS_CHANGE_OPERATION, CT.SYS_CHANGE_COLUMNS,
    CT.SYS_CHANGE_CONTEXT
FROM
    SalesLT.Product AS P
RIGHT OUTER JOIN
    CHANGETABLE(CHANGES SalesLT.Product, @last_synchronization_version) AS CT
ON
    P.ProductID = CT.ProductID;

select CHANGE_TRACKING_CURRENT_VERSION();

declare @last_synchronization_version1 bigint = CHANGE_TRACKING_CURRENT_VERSION();

SELECT
    CT.ProductID, P.Name, P.ListPrice, CT.SYS_CHANGE_VERSION,
    CT.SYS_CHANGE_OPERATION, CT.SYS_CHANGE_COLUMNS,
    CT.SYS_CHANGE_CONTEXT
FROM
    SalesLT.Product AS P
RIGHT OUTER JOIN
    CHANGETABLE(CHANGES SalesLT.Product, @last_synchronization_version1) AS CT
ON
    P.ProductID = CT.ProductID;

-- go back X version

SELECT
    CT.ProductID, P.Name, P.ListPrice,
    CT.SYS_CHANGE_OPERATION, CT.SYS_CHANGE_COLUMNS,
    CT.SYS_CHANGE_CONTEXT
FROM
    SalesLT.Product AS P
RIGHT OUTER JOIN
    CHANGETABLE(CHANGES SalesLT.Product, 14) AS CT
ON
    P.ProductID = CT.ProductID;

-- ####

-- get rows that only have a change in the SIZE column

DECLARE @SizeColumnId int = COLUMNPROPERTY(
    OBJECT_ID('SalesLT.Product'),'Size', 'ColumnId');

SELECT
    CT.sys_change_version,
    CT.ProductID, P.Name, P.Size,
    CT.SYS_CHANGE_OPERATION, CT.SYS_CHANGE_COLUMNS,
    CT.SYS_CHANGE_CONTEXT
FROM
    SalesLT.Product AS P
    RIGHT OUTER JOIN
    CHANGETABLE(CHANGES SalesLT.Product, 0) AS CT
    ON
    P.ProductID = CT.ProductID
where CHANGE_TRACKING_IS_COLUMN_IN_MASK(@SizeColumnId, CT.SYS_CHANGE_COLUMNS) = 1
and CT.SYS_CHANGE_OPERATION = 'U'
order by CT.sys_change_version;