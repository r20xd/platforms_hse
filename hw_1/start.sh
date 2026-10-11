#!/usr/bin/env bash

ssh -i "$HOME/.ssh/team_internal" team@team-13-nn '~/hadoop-3.4.0/bin/hdfs --daemon start namenode'

"$HOME/hadoop-3.4.0/bin/hdfs" --daemon start datanode

for host in team-13-00 team-13-01; do
    ssh -i "$HOME/.ssh/team_internal" "team@$host" '~/hadoop-3.4.0/bin/hdfs --daemon start datanode'
done

"$HOME/hadoop-3.4.0/bin/hdfs" --daemon start secondarynamenode
