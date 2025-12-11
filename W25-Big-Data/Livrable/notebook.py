# Databricks notebook source
# MAGIC %md
# MAGIC
# MAGIC ## Overview
# MAGIC
# MAGIC This notebook will show you how to create and query a table or DataFrame that you uploaded to DBFS. [DBFS](https://docs.databricks.com/user-guide/dbfs-databricks-file-system.html) is a Databricks File System that allows you to store data for querying inside of Databricks. This notebook assumes that you have a file already inside of DBFS that you would like to read from.
# MAGIC
# MAGIC This notebook is written in **Python** so the default cell type is Python. However, you can use different languages by using the `%LANGUAGE` syntax. Python, Scala, SQL, and R are all supported.

# COMMAND ----------

from pyspark.sql.functions import col, year, month, count, row_number, avg, unix_timestamp, sum
from pyspark.sql.window import Window

# Combine all parquet files in one dataframe
df = spark.read.parquet("/FileStore/tables/*.parquet")

# COMMAND ----------

# Cleaning dataframe
df_clean = df.filter(
    (year("tpep_pickup_datetime").between(2024, 2025)) & 
    (month("tpep_pickup_datetime").between(1, 12)) &
    (col("passenger_count") > 0) &
    (col("trip_distance") > 0) &
    (col("fare_amount") > 0) &
    (col("tip_amount") >= 0) &
    (col("payment_type").between(-1, 7))
)
df_clean.printSchema()
display(df_clean)

# COMMAND ----------

# TOP 10 PICKUP LOCATION PER MONTH
# Create a window for ranking and limiting in subpart of the query
window_spec = Window.partitionBy("Year", "Month").orderBy(col("Trips").desc())

top_10_pickup_locations_per_month = df_clean \
    .withColumn("Year", year("tpep_pickup_datetime")) \
    .withColumn("Month", month("tpep_pickup_datetime")) \
    .groupBy("Year", "Month", "PULocationID") \
    .agg(
        count("tpep_dropoff_datetime").alias("Trips")
    ) \
    .withColumn("Rank", row_number().over(window_spec)) \
    .filter(col("Rank") <= 10) \
    .sort(col("Year"), col("Month"), col("Rank"))

display(top_10_pickup_locations_per_month)

# COMMAND ----------

# TRIP DURATION AVERAGE PER MONTH
average_trip_duration_per_month = df_clean \
    .withColumn("year", year("tpep_pickup_datetime")) \
    .withColumn("month", month("tpep_pickup_datetime")) \
    .withColumn("trip_duration", 
            (unix_timestamp("tpep_dropoff_datetime") - unix_timestamp("tpep_pickup_datetime")) / 60
            ) \
    .groupBy("year", "month") \
    .agg(
        avg("trip_duration").alias("avg_trip_duration")
    ) \
    .sort(col("year"), col("month"), col("avg_trip_duration"))

display(average_trip_duration_per_month)

# COMMAND ----------

# AVERAGE DISTANCE PER PAYMENT TYPE
average_distance_per_payment_type = df_clean \
    .groupBy("payment_type") \
    .agg(
        avg("trip_distance").alias("avg_trip_distance")
    ) \
    .sort(col("payment_type"))

display(average_distance_per_payment_type)

# COMMAND ----------

# AVERAGE COST PER PASSENGER NUMBER
average_cost_per_passenger_nb = df_clean \
    .groupBy("passenger_count") \
    .agg(
        avg("total_amount").alias("avg_total_amount"),
        (avg("total_amount") / col("passenger_count")).alias("avg_amount_per_passenger")
    ) \
    .sort(col("passenger_count"))

display(average_cost_per_passenger_nb)

# COMMAND ----------

# MONTHLY TIPS
monthly_tips = df_clean \
    .withColumn("year", year("tpep_pickup_datetime")) \
    .withColumn("month", month("tpep_pickup_datetime")) \
    .groupBy("year", "month") \
    .agg(
        sum("tip_amount").alias("monthly_tips")
    ) \
    .sort(col("year"), col("month"))

display(monthly_tips)

# COMMAND ----------

# PERSISTENCE
# SQL Server credentials
server_name = "cpetitsqlserver.database.windows.net"
database_name = "yellow_trip"
username = "CpHeat"
password = "Azerty123"
jdbc_url = f"jdbc:sqlserver://{server_name}:1433;database={database_name};encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;"

def write_to_sql(df, table_name, mode="overwrite"):
    df.write \
        .format("jdbc") \
        .option("url", jdbc_url) \
        .option("dbtable", table_name) \
        .option("user", username) \
        .option("password", password) \
        .option("driver", "com.microsoft.sqlserver.jdbc.SQLServerDriver") \
        .mode(mode) \
        .save()

write_to_sql(top_10_pickup_locations_per_month, "top_10_pickup_locations_per_month")
write_to_sql(average_trip_duration_per_month, "average_trip_duration_per_month")
write_to_sql(average_distance_per_payment_type, "average_distance_per_payment_type")
write_to_sql(average_cost_per_passenger_nb, "average_cost_per_passenger_nb")
write_to_sql(monthly_tips, "monthly_tips")