#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HADOOP_CONF="$HOME/hadoop-3.4.0/etc/hadoop"

cp "$SCRIPT_DIR/yarn-site.xml" "$SCRIPT_DIR/mapred-site.xml" "$HADOOP_CONF/"
mkdir -p "$HOME/hadoop-data/"{nm-local,nm-logs}
