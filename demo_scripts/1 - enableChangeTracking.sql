-- Enable Change Tracking

ALTER DATABASE CURRENT
SET CHANGE_TRACKING = ON  
(CHANGE_RETENTION = 2 DAYS, AUTO_CLEANUP = ON)  

-- Change Retention: How long the changes are kept in the database (DAYS | HOURS | MINUTES)
-- Auto Cleanup: Is the database cleaning up the side tables for you?

ALTER TABLE SalesLT.Product
ENABLE CHANGE_TRACKING  
WITH (TRACK_COLUMNS_UPDATED = ON)  

-- Track Columns Updates: stores extra information about which columns were updated

ALTER TABLE SalesLT.Customer
ENABLE CHANGE_TRACKING  
WITH (TRACK_COLUMNS_UPDATED = ON)  

-- System Tables

select db_name(database_id) [database],* from sys.change_tracking_databases;

select object_name(object_id) [table],* from sys.change_tracking_tables;

select * from dbo.MSchange_tracking_history;
