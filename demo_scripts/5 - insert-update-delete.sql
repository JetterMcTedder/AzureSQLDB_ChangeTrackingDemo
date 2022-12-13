-- insert - update - delete

insert into SalesLT.Product
OUTPUT Inserted.[ProductID]
  select N'New Product'
      ,N'FR-R92B-59'
      ,[Color]
      ,[StandardCost]
      ,[ListPrice]
      ,[Size]
      ,[Weight]
      ,[ProductCategoryID]
      ,[ProductModelID]
      ,[SellStartDate]
      ,[SellEndDate]
      ,[DiscontinuedDate]
      ,[ThumbNailPhoto]
      ,[ThumbnailPhotoFileName]
      ,newid()
      ,[ModifiedDate]
      from SalesLT.Product
      where [ProductID] = 680;

--

declare @last_synchronization_version bigint;

SELECT
    *
FROM
    CHANGETABLE(CHANGES SalesLT.Product, @last_synchronization_version) AS CT;

--

update SalesLT.Product
   set ListPrice = 1431.70
 where ProductID = 1000;

--

declare @last_synchronization_version1 bigint;

SELECT
    *
FROM
    CHANGETABLE(CHANGES SalesLT.Product, @last_synchronization_version1) AS CT;

--

delete from SalesLT.Product
where ProductID = 710;

--

declare @last_synchronization_version2 bigint;

SELECT
    *
FROM
    CHANGETABLE(CHANGES SalesLT.Product, @last_synchronization_version2) AS CT
order by CT.SYS_CHANGE_VERSION;

--
