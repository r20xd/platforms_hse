#!/usr/bin/env bash

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$REPO_DIR/env.sh"

chmod +x "$REPO_DIR"/*.sh

wget -O "$HOME/spark-3.5.9-bin-hadoop3.tgz" \
    https://archive.apache.org/dist/spark/spark-3.5.9/spark-3.5.9-bin-hadoop3.tgz
tar -xzf "$HOME/spark-3.5.9-bin-hadoop3.tgz" -C "$HOME"
