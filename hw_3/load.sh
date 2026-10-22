#!/usr/bin/env bash

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$REPO_DIR/env.sh"

"$HADOOP_HOME/bin/hdfs" dfs -mkdir -p /tmp/hw_3-input
"$HADOOP_HOME/bin/hdfs" dfs -put -f "$REPO_DIR/data/2026-10-01.csv" /tmp/hw_3-input/
"$HADOOP_HOME/bin/hdfs" dfs -put -f "$REPO_DIR/data/2026-10-02.csv" /tmp/hw_3-input/

"$HIVE_HOME/bin/beeline" -u jdbc:hive2://team-13-en:10000/default -n team -p '' -f "$REPO_DIR/load.sql"
