SHELL := /bin/bash
ACTUAL := $(shell pwd)
MIX_ENV=dev

export MIX_ENV
export ACTUAL

help:
	@echo -e "Roll. \n\nAvailable tasks:"
	@echo -e "\tmake debug\t Start iex loading project modules"
	@echo -e "\tmake doc\t Build project documentation"
	@echo -e "\tmake compile\t Compile the project"
	@echo -e "\tmake test\t Run test"
	@echo -e "\tmake clean\t Clean build assets"

.PHONY: get
get:
	mix local.hex --force;
	mix local.rebar --force;
	mix deps.get;
	mix deps.compile;

debug:
	iex -S mix

doc: compile
	mix docs;
	tar -zcf docs.tar.gz doc/;

.NOTPARALLEL: test
.PHONY: test
test: MIX_ENV=test
test:
	mix test --trace;
	mix coveralls;

.NOTPARALLEL: compile
.PHONY: compile
compile: clean get
	mix compile;
	mix docs;
	tar -zcf docs.tar.gz doc/;

clean:
	mix clean
	mix deps.clean --all
	rm -rf doc/ docs.tar.gz
	rm -rf roll-* erl_crash.dump tmp
