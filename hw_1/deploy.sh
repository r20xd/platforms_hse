#!/usr/bin/env bash

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SSH_KEY="$HOME/.ssh/team_internal"
HADOOP_ARCHIVE="$HOME/hadoop-3.4.0.tar.gz"

chmod +x "$REPO_DIR"/*.sh

wget -O "$HADOOP_ARCHIVE" https://dlcdn.apache.org/hadoop/common/hadoop-3.4.0/hadoop-3.4.0.tar.gz

tar -xzf "$HADOOP_ARCHIVE" -C "$HOME"
bash "$REPO_DIR/node-setup.sh"

for host in team-13-nn team-13-00 team-13-01; do
    scp -i "$SSH_KEY" \
        "$HADOOP_ARCHIVE" \
        "$REPO_DIR/core-site.xml" \
        "$REPO_DIR/hdfs-site.xml" \
        "$REPO_DIR/workers" \
        "$REPO_DIR/node-setup.sh" \
        "team@$host:~/"

    ssh -i "$SSH_KEY" "team@$host" '
        tar -xzf "$HOME/hadoop-3.4.0.tar.gz" -C "$HOME"
        bash "$HOME/node-setup.sh"
    '
done

ssh -i "$SSH_KEY" team@team-13-nn '
    if [ ! -f "$HOME/hadoop-data/nn/current/VERSION" ]; then
        "$HOME/hadoop-3.4.0/bin/hdfs" namenode -format -nonInteractive
    fi
'
