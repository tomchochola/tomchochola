# Default shell
SHELL := /bin/bash

# Default goal
.DEFAULT_GOAL := never

# Variables
SOURCES = $(shell git ls-files --others --exclude-standard --cached)

# Goals
.PHONY: audit
audit: audit_npm

.PHONY: audit_npm
audit_npm: ./node_modules/audit_stamp

./node_modules/audit_stamp: ./node_modules ./package-lock.json
	npm audit --audit-level info --include prod --include dev --include peer --include optional
	touch ./node_modules/audit_stamp

.PHONY: check
check: lint audit

.PHONY: clean
clean:
	rm -rf ./node_modules
	git clean -Xfd

.PHONY: commit
commit: fix fix fix check

.PHONY: development
development:

.PHONY: distclean
distclean: clean
	git clean -xfd

.PHONY: fix
fix: fix_eslint fix_prettier

.PHONY: fix_eslint
fix_eslint: ./node_modules/eslint_fix_stamp

./node_modules/eslint_fix_stamp: ./node_modules/.bin/eslint ${SOURCES}
	./node_modules/.bin/eslint --fix .
	touch ./node_modules/eslint_fix_stamp
	touch ./node_modules/eslint_lint_stamp

.PHONY: fix_prettier
fix_prettier: ./node_modules/prettier_fix_stamp

./node_modules/prettier_fix_stamp: ./node_modules/.bin/prettier ${SOURCES}
	./node_modules/.bin/prettier -w .
	touch ./node_modules/prettier_fix_stamp
	touch ./node_modules/prettier_lint_stamp

.PHONY: lint
lint: lint_eslint lint_prettier

.PHONY: lint_eslint
lint_eslint: ./node_modules/eslint_lint_stamp

./node_modules/eslint_lint_stamp: ./node_modules/.bin/eslint ${SOURCES}
	./node_modules/.bin/eslint .
	touch ./node_modules/eslint_lint_stamp
	touch ./node_modules/eslint_fix_stamp

.PHONY: lint_prettier
lint_prettier: ./node_modules/prettier_lint_stamp

./node_modules/prettier_lint_stamp: ./node_modules/.bin/prettier ${SOURCES}
	./node_modules/.bin/prettier -c .
	touch ./node_modules/prettier_lint_stamp
	touch ./node_modules/prettier_fix_stamp

.PHONY: local
local:

.PHONY: production
production:

.PHONY: staging
staging:

.PHONY: testing
testing:

.PHONY: update
update: update_npm

.PHONY: update_npm
update_npm:
	npm update --install-links --include prod --include dev --include peer --include optional

# Dependencies
./package-lock.json ./node_modules ./node_modules/.bin/eslint ./node_modules/.bin/prettier: package.json
	npm install --install-links --include prod --include dev --include peer --include optional
