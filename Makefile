
# \ <section:top>
# powered by metaL: https://repl.it/@metaLmasters/metaL#README.md 
# @file# @file

# \ <section:vars>
MODULE   = $(notdir $(CURDIR))
OS      ?= $(shell uname -s)
# / <section:vars>

# \ <section:version>
NOW      = $(shell date +%d%m%y)
REL      = $(shell git rev-parse --short=4 HEAD)
# / <section:version>

# \ <section:dirs>
CWD      = $(CURDIR)
TMP      = $(CWD)/tmp
SOURCE   = $(TMP)/src
# / <section:dirs>

# \ <section:tools>
WGET     = wget -c --no-check-certificate
CORES    = $(shell grep proc /proc/cpuinfo|wc -l)
XMAKE    = $(XPATH) $(MAKE) -j$(CORES)
# / <section:tools>
# / <section:top>
# \ <section:mid>
# / <section:mid>
# \ <section:bot>

# \ <section:install>
.PHONY: install
install:
	$(MAKE) $(OS)_install
# / <section:install>

# \ <section:update>
.PHONY: update
update:
	$(MAKE) $(OS)_update
# / <section:update>

# \ <section:linux/install>
.PHONY: Linux_install Linux_update
Linux_install Linux_update:
	sudo apt update
	sudo apt install -u `cat apt.txt`

# / <section:linux/install>

# \ <section:merge>
MERGE  = Makefile apt.txt .gitignore
MERGE += README.md
# / <section:merge>
master:
	git checkout $@
	git pull -v
	git checkout shadow -- $(MERGE)
shadow:
	git checkout $@
	git pull -v
release:
	git tag $(NOW)-$(REL)
	git push -v && git push -v --tags
	$(MAKE) shadow
# / <section:bot>