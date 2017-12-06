#ref http://clarkgrubb.com/makefile-style-guide
VERSION := $(shell $(MAKE) --version)
ifneq ($(firstword $(VERSION)),GNU)
  $(error Need GNU Make)
endif

# set language
_LANGS_ := go
# ugly guess lang
guess_lang = $(firstword $(filter $(_LANGS_), $(patsubst .%,%,$(suffix $(wildcard *)))))
CC_LANG := $(if $(CC_LANG),$(CC_LANG),$(call guess_lang))

# calculate include mk file
INCLUDE_MK = remote.$(CC_LANG).mk

# REMOTE BASE
DEFAULT_MK_FILE_LOC := quar.github.io/makefiles
MK_FILE_LOC := $(if $(MK_FILE_LOC),$(MK_FILE_LOC),$(DEFAULT_MK_FILE_LOC))
MK_FILE_PATH = $(MK_FILE_LOC)/$(INCLUDE_MK)


define get_mk_files
  $(MAKE) _mk_files
endef

_GET_INCLUDE_MK_ := $(call get_mk_files)


# https://stackoverflow.com/questions/30386774
include $(INCLUDE_MK)

#### TASKS ####
.DEFAULT_GOAL := help


#ref https://swcarpentry.github.io/make-novice/08-self-doc/
.PHONY: help
help: GNUmakefile $(INCLUDE_MK)
	@echo "Guessed Language: $(CC_LANG)"
	@echo availble tasks:
	@sed -n 's/^##HELP //p' $^


##HELP env -- show environment variables
.PHONY: env
env:
	@$(foreach V, $(sort $(.VARIABLES)), \
	  $(if $(filter-out environment% default automatic, \
	  $(origin $V)), $(info $V=$($V))))
	@echo


##HELP guess -- guess language and includes
.PHONY: guess
guess:
	@echo "lang=$(CC_LANG)"
	@echo "include=$(INCLUDE_MK)"


$(INCLUDE_MK):
	@if [ -d $(MK_FILE_LOC) ]; then \
	  cp $(MK_FILE_PATH) . ;\
	else \
	  wget $(MK_FILE_PATH) . ; \
	fi

