TRUNCATE TABLE silver.erp_location
INSERT INTO silver.erp_location(cid, cntry)
SELECT REPLACE(cid, '-', '')
    , CASE 
        WHEN UPPER(TRIM(REPLACE(REPLACE(cntry, CHAR(13), ''), CHAR(10), ''))) IN ('US', 'USA')
            THEN 'United States'
        WHEN UPPER(TRIM(REPLACE(REPLACE(cntry, CHAR(13), ''), CHAR(10), ''))) = 'DE'
            THEN 'Germany'
        WHEN UPPER(TRIM(REPLACE(REPLACE(cntry, CHAR(13), ''), CHAR(10), ''))) = ''
            OR UPPER(TRIM(REPLACE(REPLACE(cntry, CHAR(13), ''), CHAR(10), ''))) IS NULL
            THEN 'Unknown'
        ELSE TRIM(REPLACE(REPLACE(cntry, CHAR(13), ''), CHAR(10), ''))
        END AS cntry
FROM bronze.erp_location;