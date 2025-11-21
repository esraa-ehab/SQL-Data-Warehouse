------------------------------------------
-- Data Exploration before transformation
------------------------------------------

-- ===================
-- erp_customer table
-- ===================
-- identify out of range tables 
SELECT DISTINCT bdate
FROM bronze.erp_customer
WHERE bdate > GETDATE() OR bdate < '1924-01-01';

-- data conssistency
SELECT distinct gen
FROM bronze.erp_customer;


-- ===================
-- erp_location table
-- ===================
SELECT DISTINCT cntry
FROM bronze.erp_location


-- ===================
-- erp_categories table
-- ===================
SELECT DISTINCT maintenance
FROM bronze.erp_px_cat

------------------------------------------
-- Data Exploration after transformation
------------------------------------------

-- ===================
-- erp_customer table
-- ===================
-- identify out of range tables 
SELECT DISTINCT bdate
FROM silver.erp_customer
WHERE bdate > GETDATE() OR bdate < '1924-01-01';

-- data conssistency
SELECT distinct gen, COUNT(*)
FROM silver.erp_customer
GROUP BY gen

-- ===================
-- erp_location table
-- ===================
SELECT DISTINCT cntry
FROM silver.erp_location


-- ===================
-- erp_categories table
-- ===================
SELECT DISTINCT maintenance
FROM bronze.erp_px_cat