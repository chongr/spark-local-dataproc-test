from pyspark.sql import SparkSession
import arrow


def main():
    # Initialize SparkSession
    spark = SparkSession.builder \
        .appName("HelloWorld") \
        .getOrCreate()

    # Create an RDD containing numbers from 1 to 1000
    numbers_rdd = spark.sparkContext.parallelize(range(1, 1000))

    # Count the elements in the RDD
    count = numbers_rdd.count()
    print(f"current time from arrow: {arrow.utcnow()}")

    print(f"Count of numbers from 1 to 1000 is: {count}")

    # Stop the SparkSession
    spark.stop()


if __name__ == "__main__":
    main()
