import os
import subprocess
from pathlib import Path

from prefect import flow, task


SCRIPT_DIR = Path(__file__).resolve().parent


@task(name="spark-transform")
def transform_sales():
    subprocess.run(
        [
            Path(os.environ["SPARK_HOME"]) / "bin/spark-submit",
            "--master", "yarn",
            "--deploy-mode", "client",
            "--num-executors", "2",
            "--executor-cores", "1",
            "--executor-memory", "1g",
            "--conf", "spark.sql.shuffle.partitions=2",
            "--conf", "spark.yarn.am.clientModeExitOnError=true",
            SCRIPT_DIR / "transform.py",
        ],
        check=True,
    )


@task(name="publish-hive-table")
def publish_table():
    subprocess.run(
        [
            Path(os.environ["HIVE_HOME"]) / "bin/beeline",
            "-u", "jdbc:hive2://team-13-en:10000/default",
            "-n", "team",
            "-p", "",
            "-f", SCRIPT_DIR / "table.sql",
        ],
        check=True,
    )


@flow(name="hw_5")
def sales_flow():
    transform_sales()
    publish_table()


if __name__ == "__main__":
    sales_flow()
