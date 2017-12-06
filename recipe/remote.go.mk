# config remote
REMOTE_HOST := qt
REMOTE_PATH := ~/_test_

SSH_OPT := -qt

REMOTE_URL := $(REMOTE_HOST):'$(REMOTE_PATH)'
REMOTE_CMD = ./$(MAIN)

# default main as 1st of targets
MAIN = $(firstword $(TARGETS))
MAIN_DIR = $(REMOTE_PATH)/$(notdir $(PWD))

# config go build
CC = go build

ENV = GOOS=$(GOOS) GOARCH=$(GOARCH)
GOOS := $(if $(GOOS),$(GOOS),"linux")
GOARCH := $(if $(GOARCH),$(GOARCH),"amd64")

# define source files
SOURCES := $(wildcard *.go)
TARGETS := $(SOURCES:.go=)
rm = rm -f

# prompt
PROMPT = '==>'
__ = @echo $(PROMPT)


#### TASKS ####
.DEFAULT_GOAL := help


$(TARGETS): $(SOURCES)
	$(ENV) $(CC) $(SOURCES)
	@echo "Compilation complete."


##HELP clean -- clean bulit golang app
.PHONY: clean
clean:
	@$(rm) $(TARGETS)
	$(__) "Cleanup."


##HELP push -- push $PWD to REMOTE_HOST/REMOTE_PATH
.PHONY: push
push: $(TARGETS)
	@rsync -avz $(PWD) $(REMOTE_URL)
	$(__) "Push done."


##HELP run_remote -- push and echo run MAIN in REMOTE_HOST
.PHONY: run_remote
run_remote: push
	@echo
	@echo '----- echo from $(REMOTE_HOST) -----'
	@ssh $(SSH_OPT) $(REMOTE_HOST) 'cd $(MAIN_DIR); $(REMOTE_CMD)'


