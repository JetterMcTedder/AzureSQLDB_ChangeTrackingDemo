-- multi column

update SalesLT.Product
   set Size = N'S',
       Weight = 10
 where ProductID = 808;

SELECT
    *
FROM
    CHANGETABLE(CHANGES SalesLT.Product, 0) AS CT
order by 1;

--

select 
    CHANGE_TRACKING_IS_COLUMN_IN_MASK(COLUMNPROPERTY(OBJECT_ID('SalesLT.Product'), 'Size', 'ColumnId'), CT.SYS_CHANGE_COLUMNS) 'Size Changed?', *
FROM
    CHANGETABLE(CHANGES SalesLT.Product, 0) AS CT
order by sys_change_version;
