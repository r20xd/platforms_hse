#!/usr/bin/env bash

source "$(dirname "${BASH_SOURCE[0]}")/env.sh"

"$JAVA_HOME/bin/jps" -l
ss -ltn '( sport = :5432 or sport = :9083 or sport = :10000 )'
"$HIVE_HOME/bin/beeline" -u jdbc:hive2://team-13-en:10000/default -n team -p '' -e 'SHOW DATABASES;'
