from pyspark.sql import SparkSession
from pyspark.sql import functions as F


spark = SparkSession.builder.appName("hw_5").getOrCreate()

sales = (
    spark.read
    .schema("id INT, product STRING, amount STRING")
    .csv("hdfs://team-13-nn:8020/user/hive/warehouse-external/hw_3/sales")
)

summary = (
    sales
    .withColumn("product", F.upper(F.trim(F.col("product"))))
    .withColumn("amount", F.col("amount").cast("int"))
    .filter(F.col("amount") > 0)
    .groupBy("product")
    .agg(
        F.sum("amount").alias("total_amount"),
        F.count("*").alias("sales_count"),
    )
)

summary.write.mode("overwrite").parquet(
    "hdfs://team-13-nn:8020/user/team/hw_5/sales_by_product"
)

spark.stop()
