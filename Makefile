## Build/rebuild/check 4.3BSD distribution tape from authorative sources at:
##
##     https://www.tuhs.org/Archive/Distributions/UCB/4.3BSD
##
## By default the sources are cached and checked into the git repo, which is
## slightly unusual. This means unless the `reallyclean` rule is invoked to
## forcibly re-download the sources, invoking `make all` will simply rebuild
## the tape from the existing impounded downloads and check the hashes.
##
## To completely re-download and rebuild everything, run: `make reallyclean all`
##
##    make [<target>...]
##
##    targets:
##        all (default) - ensures everything is updated and checked
##        clean         - removes everything except downloaded sources
##        reallyclean   - removes everything, including downloaded sources
##        help          - print this help message
##        curlit        - (re-)downloads source files/tapes
##        unzipit       - unzips downloaded sources
##        tapit         - create the distribution tape
##        checkit       - checks the sources and tape against sha256 hashes
##        updateit      - create/updates the sha256 hash test file
##
##    overridable variables:
##        MIRROR        - overrides the mirror url
##        TAPNAME       - defaults to 4.3BSD-dist.tap
##        MKSIMTAPE     - path to the simh simtools `mksimtape` tool
##

.PHONY: all clean reallyclean help
.PHONY: curlit unzipit tapit checkit updateit

MIRROR = https://www.tuhs.org/Archive/Distributions/UCB/4.3BSD

# NOTE: this is the correct order for 4.3BSD. In 4.2BSD the order of srcsys
# and usr are reversed from this. Many scripts do not account for this.
FILES = \
  stand \
  miniroot \
  rootdump \
  usr.tar \
  srcsys.tar \
  src.tar \
  vfont.tar \
  new.tar \
  ingres.tar

# this can be overridden if this is not a peer submodule
MKSIMTAPE = ../simhtools/converters/mksimtape/mksimtape

# well, this rather sucks :(
sp :=
sp +=
cm := ,

# commas separated, no spaces
FILELIST = $(subst $(sp),$(cm),$(FILES))
GZFILES = $(FILES:%=%.gz)

TAPNAME = 4.3BSD-dist.tap

all: checkit

clean:
	$(RM) $(FILES) $(TAPNAME)

reallyclean: clean
	$(RM) $(GZFILES)

help:
	awk -F'## ' '/^##/{print $$2}' $(lastword $(MAKEFILE_LIST)) | more
	
curlit: $(GZFILES)

$(GZFILES):
	curl -O "${MIRROR}/$@"

unzipit: $(FILES)

%: %.gz
	gunzip -c $< > $@

tapit: $(TAPNAME)

$(TAPNAME): $(FILES) $(MKSIMTAPE)
	$(MKSIMTAPE) stand:512 $(filter-out stand,$(FILES)) > $(TAPNAME)

checkit: $(GZFILES) $(TAPNAME)
	sha256sum -c sha256check.txt

updateit:
	sha256sum $(GZFILES) $(TAPNAME) > sha256check.txt
