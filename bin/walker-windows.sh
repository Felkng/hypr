#!/bin/bash
if pgrep -x "walker" > /dev/null; then
    # Walker is already running, let it handle the internal cycling
    exit 0
else
    walker --provider windows
fi
