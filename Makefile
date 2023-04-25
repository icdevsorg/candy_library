.PHONY: check docs test

install-dfx-cache: 
	dfx cache install

check:
	find src -type f -name '*.mo' -print0 | xargs -0 $(shell dfx cache show)/moc $(shell vessel sources) --check

check-mops:
	find src -type f -name '*.mo' -print0 | xargs -0 $(shell dfx cache show)/moc $(shell mops sources) --check

all: check-strict check-strict-mops docs test

check-strict:
	find src -type f -name '*.mo' -print0 | xargs -0 $(shell dfx cache show)/moc $(shell vessel sources) -Werror --check

check-strict-mops:
	find src -type f -name '*.mo' -print0 | xargs -0 $(shell dfx cache show)/moc $(shell mops sources) -Werror --check

docs:
	$(shell dfx cache show)/mo-doc

test:
	printf "yes" | bash test_runner.sh
