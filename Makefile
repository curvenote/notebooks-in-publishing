.PHONY: clean create test-base test-myst test-quarto test

clean:
	sh ./bin/clean.sh

create: clean
	sh ./bin/create.sh

test-base:
	sh ./bin/test.sh

test-myst:
	sh ./bin/test.sh myst

test-quarto:
	sh ./bin/test.sh quarto

test: create
	sh ./bin/test.sh
	sh ./bin/test.sh myst
	sh ./bin/test.sh quarto

