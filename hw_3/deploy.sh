#!/usr/bin/env bash

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$REPO_DIR/env.sh"

chmod +x "$REPO_DIR"/*.sh

wget -O "$HOME/apache-hive-4.0.0-alpha-2-bin.tar.gz" https://archive.apache.org/dist/hive/hive-4.0.0-alpha-2/apache-hive-4.0.0-alpha-2-bin.tar.gz
tar -xzf "$HOME/apache-hive-4.0.0-alpha-2-bin.tar.gz" -C "$HOME"

sudo apt-get install -y postgresql libpostgresql-jdbc-java
sudo systemctl enable --now postgresql
cp /usr/share/java/postgresql.jar "$HIVE_HOME/lib/"
cp "$REPO_DIR/hive-site.xml" "$HIVE_CONF_DIR/"
mkdir -p "$HIVE_HOME/logs" "$HIVE_HOME/run"

sudo -u postgres psql -v ON_ERROR_STOP=1 <<'SQL'
CREATE ROLE hive LOGIN PASSWORD 'hive_team13';
CREATE DATABASE metastore OWNER hive;
SQL

"$HADOOP_HOME/bin/hdfs" dfs -mkdir -p /tmp /user/hive/warehouse /user/hive/warehouse-external
"$HADOOP_HOME/bin/hdfs" dfs -chmod 1777 /tmp

"$HIVE_HOME/bin/schematool" -dbType postgres -initSchema
