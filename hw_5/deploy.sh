#!/usr/bin/env bash

PREFECT_ENV="$HOME/.venvs/hw_5"

python3 -m venv "$PREFECT_ENV" &&
    "$PREFECT_ENV/bin/python" -m pip install 'prefect==3.9.2'
