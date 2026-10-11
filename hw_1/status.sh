#!/usr/bin/env bash

echo team-13-en
/usr/lib/jvm/java-11-openjdk-amd64/bin/jps

for host in team-13-nn team-13-00 team-13-01; do
    echo "$host"
    ssh -i "$HOME/.ssh/team_internal" "team@$host" '/usr/lib/jvm/java-11-openjdk-amd64/bin/jps'
done

"$HOME/hadoop-3.4.0/bin/hdfs" dfsadmin -report
