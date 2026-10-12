#!/usr/bin/env bash

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SSH_KEY="$HOME/.ssh/team_internal"

chmod +x "$REPO_DIR"/*.sh
bash "$REPO_DIR/node-setup.sh"

for host in team-13-nn team-13-00 team-13-01; do
    scp -i "$SSH_KEY" \
        "$REPO_DIR/yarn-site.xml" \
        "$REPO_DIR/mapred-site.xml" \
        "$REPO_DIR/node-setup.sh" \
        "team@$host:~/"
    ssh -i "$SSH_KEY" "team@$host" 'bash ~/node-setup.sh'
done

HDFS="$HOME/hadoop-3.4.0/bin/hdfs"
"$HDFS" dfs -mkdir -p /user/team /mr-history/tmp /mr-history/done /yarn-logs
"$HDFS" dfs -chmod 1777 /mr-history/tmp /yarn-logs
"$HDFS" dfs -chmod 750 /mr-history/done
