GODOT_BIN ?= godot4

# default objective, "all" (by convention)
# require tests to run
# PHONY means "always rebuild" or "never use a cached result"
.PHONY: all
all: tests

# tests use our helper ./run_tests.sh. we can add more requirements here or in run_tests.sh
.PHONY: tests
tests:
	GODOT_BIN="$(GODOT_BIN)" ./run_tests.sh
