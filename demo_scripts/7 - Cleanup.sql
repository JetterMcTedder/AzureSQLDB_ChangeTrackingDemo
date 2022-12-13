-- Clean it up

-- Version check

select CHANGE_TRACKING_CURRENT_VERSION();

ALTER DATABASE CURRENT  
SET CHANGE_TRACKING (CHANGE_RETENTION = 1 MINUTES);

-- Returns the minimum version on the client that is valid for use in obtaining change tracking information from the specified table

select CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID('SalesLT.Product'));

select CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID('SalesLT.Customer'));

select object_name(object_id) [table],* from sys.change_tracking_tables;


-- Manual Cleanup

exec sys.sp_flush_CT_internal_table_on_demand;

select CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID('SalesLT.Product'));

select CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID('SalesLT.Customer'));

select * from dbo.MSchange_tracking_history;

--
