.PHONY: check docs test

install-dfx-cache: 
	dfx cache install

check: install-dfx-cache
	find src -type f -name '*.mo' -print0 | xargs -0 $(shell dfx cache show)/moc $(shell vessel sources) --check

check-mops: install-dfx-cache
	find src -type f -name '*.mo' -print0 | xargs -0 $(shell dfx cache show)/moc $(shell mops sources) --check

all: check-strict check-strict-mops docs test

check-strict: install-dfx-cache
	find src -type f -name '*.mo' -print0 | xargs -0 $(shell dfx cache show)/moc $(shell vessel sources) -Werror --check

check-strict-mops: install-dfx-cache
	find src -type f -name '*.mo' -print0 | xargs -0 $(shell dfx cache show)/moc $(shell mops sources) -Werror --check

docs: install-dfx-cache
	$(shell dfx cache show)/mo-doc

test:
	printf "yes" | bash test_runner.sh
