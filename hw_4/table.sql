CREATE DATABASE IF NOT EXISTS hw_4;

CREATE EXTERNAL TABLE IF NOT EXISTS hw_4.sales_summary (
    product STRING,
    total_amount BIGINT,
    sales_count BIGINT
)
PARTITIONED BY (sale_date STRING)
STORED AS PARQUET
LOCATION '/user/team/hw_4/sales_summary';

MSCK REPAIR TABLE hw_4.sales_summary;
SHOW PARTITIONS hw_4.sales_summary;
SELECT * FROM hw_4.sales_summary WHERE sale_date='2026-10-01';
SELECT * FROM hw_4.sales_summary WHERE sale_date='2026-10-02';
