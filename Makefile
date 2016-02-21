SHELL := /bin/bash
VIRTUALENV_BIN ?= $(shell which virtualenv)
VIRTUALENV_DIR ?= ${PWD}/.venv

.SHELLFLAGS := -ex -o pipefail -c

clean :
	cd tests; \
	vagrant destroy -f;

env :
	${VIRTUALENV_BIN} ${VIRTUALENV_DIR}; \
	${VIRTUALENV_DIR}/bin/pip install -U 'ansible>=2.0,<2.1'; \

test : env
	source ${VIRTUALENV_DIR}/bin/activate; \
	cd tests; \
	if vagrant status | grep "not created" > /dev/null; then \
		vagrant up --provision; \
	else \
		vagrant provision; \
	fi
