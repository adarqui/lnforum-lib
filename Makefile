build:
	stack build --fast

docs:
	cabal haddock --hyperlink-source

build-watch:
	stack build --file-watch

install:
	stack install

ghci:
	stack ghci ln-lib

icu:
	cabal install text-icu --extra-lib-dirs=/usr/local/opt/icu4c/lib --extra-include-dirs=/usr/local/opt/icu4c/include
