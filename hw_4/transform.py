from pyspark.sql import SparkSession
from pyspark.sql import functions as F

spark = SparkSession.builder.appName("hw_4").getOrCreate()

sales = (
    spark.read
    .schema("id STRING, product STRING, amount STRING")
    .csv("hdfs://team-13-nn:8020/user/hive/warehouse-external/hw_3/sales")
)

summary = (
    sales
    .withColumn("amount", F.col("amount").cast("int"))
    .withColumn("sale_date", F.col("sale_date").cast("string"))
    .withColumn("product", F.upper(F.trim(F.col("product"))))
    .filter(F.col("amount") > 0)
    .groupBy("sale_date", "product")
    .agg(
        F.sum("amount").alias("total_amount"),
        F.count("*").alias("sales_count"),
    )
)

(
    summary.write
    .mode("overwrite")
    .partitionBy("sale_date")
    .parquet("hdfs://team-13-nn:8020/user/team/hw_4/sales_summary")
)

spark.stop()
