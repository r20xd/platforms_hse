CREATE DATABASE IF NOT EXISTS hw_3;

CREATE EXTERNAL TABLE IF NOT EXISTS hw_3.sales (
    id INT,
    product STRING,
    amount INT
)
PARTITIONED BY (sale_date STRING)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/user/hive/warehouse-external/hw_3/sales';

LOAD DATA INPATH '/tmp/hw_3-input/2026-10-01.csv'
OVERWRITE INTO TABLE hw_3.sales PARTITION (sale_date='2026-10-01');

LOAD DATA INPATH '/tmp/hw_3-input/2026-10-02.csv'
OVERWRITE INTO TABLE hw_3.sales PARTITION (sale_date='2026-10-02');

SHOW PARTITIONS hw_3.sales;
SELECT * FROM hw_3.sales WHERE sale_date='2026-10-01';
SELECT * FROM hw_3.sales WHERE sale_date='2026-10-02';
