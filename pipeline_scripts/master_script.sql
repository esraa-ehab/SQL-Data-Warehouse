-- ========================================================
-- Master ETL Driver Script
-- ========================================================
DECLARE @startStep DATETIME2, @endStep DATETIME2;
SET @startStep = SYSDATETIME();

PRINT '================================================';
PRINT ' Starting full data warehouse build process';
PRINT '================================================';

PRINT '----------------------------'
PRINT 'Step 1: initialize database'
PRINT '----------------------------'
:r ./pipeline_scripts/init_database.sql
GO

PRINT '---------------------'
PRINT 'Step 2: Bronze Layer'
PRINT '---------------------'
PRINT '>> Loading Bronze layer';
:r ./pipeline_scripts/bronze_layer/excute_bronze_layer.sql
GO

PRINT '---------------------'
PRINT 'Step 3: Silver Layer'
PRINT '---------------------'
PRINT '>> Running Silver layer transformations';
:r ./pipeline_scripts/silver_layer/run_all_transformations.sql
GO

PRINT '-------------------'
PRINT 'Step 4: Gold Layer'
PRINT '-------------------'
PRINT '>> Creating Gold layer views';
:r ./pipeline_scripts/gold_layer/create_gold_views.sql
GO

PRINT '=================================';
PRINT ' All layers built successfully';
PRINT '=================================';
GO