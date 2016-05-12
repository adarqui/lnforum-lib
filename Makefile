docs:
	cabal haddock --hyperlink-source

build:
	stack build --file-watch

install:
	stack install

ghci:
	stack ghci ln-lib
