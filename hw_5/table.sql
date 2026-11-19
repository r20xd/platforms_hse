CREATE DATABASE IF NOT EXISTS hw_5;

CREATE EXTERNAL TABLE IF NOT EXISTS hw_5.sales_by_product (
    product STRING,
    total_amount BIGINT,
    sales_count BIGINT
)
STORED AS PARQUET
LOCATION '/user/team/hw_5/sales_by_product';

SELECT product, total_amount, sales_count FROM hw_5.sales_by_product;
