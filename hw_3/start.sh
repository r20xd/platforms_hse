#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/env.sh"

nohup "$HIVE_HOME/bin/hive" --service metastore \
    > "$HIVE_HOME/logs/metastore.out" 2>&1 < /dev/null &
echo $! > "$HIVE_HOME/run/metastore.pid"

nohup "$HIVE_HOME/bin/hive" --service hiveserver2 \
    > "$HIVE_HOME/logs/hiveserver2.out" 2>&1 < /dev/null &
echo $! > "$HIVE_HOME/run/hiveserver2.pid"
