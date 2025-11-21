TRUNCATE TABLE silver.erp_px_cat
INSERT INTO silver.erp_px_cat(id, cat, subcat, maintenance)
SELECT id
    , cat
    , subcat
    , CASE 
        WHEN UPPER(TRIM(REPLACE(REPLACE(maintenance, CHAR(13), ''), CHAR(10), ''))) = 'YES'
            THEN 'Yes'
        WHEN UPPER(TRIM(REPLACE(REPLACE(maintenance, CHAR(13), ''), CHAR(10), ''))) = 'NO'
            THEN 'No'
        ELSE maintenance
    END AS maintenance
FROM bronze.erp_px_cat;