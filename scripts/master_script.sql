PRINT '================================================';
PRINT '    Starting full data warehouse build process   ';
PRINT '================================================';
GO
:r ./scripts/bronze_layer/load_data_from_csv.sql
:r ./scripts/silver_layer/run_all_transformations.sql
:r ./scripts/gold_layer/create_gold_views.sql
PRINT 'All layers built successfully.';
