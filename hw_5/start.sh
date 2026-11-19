#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../hw_4/env.sh" || exit 1

export PREFECT_HOME="$HOME/.venvs/hw_5/.prefect"
export PREFECT_SERVER_EPHEMERAL_ENABLED=true
export PREFECT_SERVER_ANALYTICS_ENABLED=false
exec "$HOME/.venvs/hw_5/bin/python" "$SCRIPT_DIR/flow.py"
