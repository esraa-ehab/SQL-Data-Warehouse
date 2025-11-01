USE master; 

IF EXISTS(SELECT 1 from sys.databases WHERE name = 'DataWareHouse')
BEGIN
    ALTER DATABASE DataWareHouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE
    DROP DATABASE DataWareHouse
END

CREATE DATABASE DataWareHouse;

USE DataWareHouse; 

CREATE SCHEMA bronze;

CREATE SCHEMA silver;

CREATE SCHEMA gold;