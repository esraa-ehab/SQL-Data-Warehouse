-- loading to CRM tables
TRUNCATE TABLE bronze.crm_customer_info

BULK INSERT bronze.crm_customer_info
FROM '/data/Data_Engineering/SQL-Data-Warehouse/datasets/source_crm/cust_info.csv' WITH (
        FIRSTROW=2
        , FIELDTERMINATOR = ','
        , TABLOCK
        );


TRUNCATE TABLE bronze.crm_product_info

BULK INSERT bronze.crm_product_info
FROM '/data/Data_Engineering/SQL-Data-Warehouse/datasets/source_crm/prd_info.csv' WITH (
        FIRSTROW=2
        , FIELDTERMINATOR = ','
        , TABLOCK
        );


TRUNCATE TABLE bronze.crm_sales_info

BULK INSERT bronze.crm_sales_info
FROM '/data/Data_Engineering/SQL-Data-Warehouse/datasets/source_crm/sales_details.csv' WITH (
        FIRSTROW=2
        , FIELDTERMINATOR = ','
        , TABLOCK
        );


-- loading to ERP tables
TRUNCATE TABLE bronze.erp_customer

BULK INSERT bronze.erp_customer
FROM '/data/Data_Engineering/SQL-Data-Warehouse/datasets/source_erp/CUST_AZ12.csv' WITH (
        FIRSTROW=2
        , FIELDTERMINATOR = ','
        , TABLOCK
        );


TRUNCATE TABLE bronze.erp_location

BULK INSERT bronze.erp_location
FROM '/data/Data_Engineering/SQL-Data-Warehouse/datasets/source_erp/LOC_A101.csv' WITH (
        FIRSTROW=2
        , FIELDTERMINATOR = ','
        , TABLOCK
        );


TRUNCATE TABLE bronze.erp_px_cat

BULK INSERT bronze.erp_px_cat
FROM '/data/Data_Engineering/SQL-Data-Warehouse/datasets/source_erp/PX_CAT_G1V2.csv' WITH (
        FIRSTROW=2
        , FIELDTERMINATOR = ','
        , TABLOCK
        );