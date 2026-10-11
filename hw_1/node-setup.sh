#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HADOOP_CONF="$HOME/hadoop-3.4.0/etc/hadoop"

sudo sed -i -E \
  '/^127\.0\.1\.1[[:space:]].*(team-13-nn|team-13-en|team-13-00|team-13-01)([[:space:]]|$)/d;
   /^10\.13\.0\.(10|11|12|13)[[:space:]].*(team-13-nn|team-13-en|team-13-00|team-13-01)([[:space:]]|$)/d' /etc/hosts

sudo tee -a /etc/hosts > /dev/null <<'EOF'
10.13.0.10 team-13-en
10.13.0.11 team-13-nn
10.13.0.12 team-13-00
10.13.0.13 team-13-01
EOF

sudo apt-get install -y openjdk-11-jdk

cp "$SCRIPT_DIR/core-site.xml" "$SCRIPT_DIR/hdfs-site.xml" "$SCRIPT_DIR/workers" "$HADOOP_CONF/"

sed -i '/^export JAVA_HOME=/d' "$HADOOP_CONF/hadoop-env.sh"
echo 'export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64' >> "$HADOOP_CONF/hadoop-env.sh"

mkdir -p "$HOME/hadoop-data/"{nn,dn,snn,snn-edits}
