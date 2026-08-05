#!/bin/sh
# strict error handling
set -eu

# defaults
: "${GODOT_BIN:=godot4}"

# verbose logging
set -x

"${GODOT_BIN}" -s tests/run_tests.gd --headless
