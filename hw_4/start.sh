#!/usr/bin/env bash

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$REPO_DIR/env.sh"

"$SPARK_HOME/bin/spark-submit" \
    --master yarn \
    --deploy-mode client \
    --num-executors 2 \
    --executor-cores 1 \
    --executor-memory 1g \
    --conf spark.sql.shuffle.partitions=2 \
    --conf spark.yarn.tags=hw_4 \
    --conf spark.yarn.am.clientModeExitOnError=true \
    "$REPO_DIR/transform.py" &&
"$HIVE_HOME/bin/beeline" -u jdbc:hive2://team-13-en:10000/default -n team -p '' -f "$REPO_DIR/table.sql"
