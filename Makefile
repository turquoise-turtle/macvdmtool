CXX      ?= c++
CXXFLAGS ?= -std=c++14 -Wall -Wextra -target arm64-apple-macos12.0
LDFLAGS  ?= -framework CoreFoundation -framework IOKit -lc++

all: macvdmtool

macvdmtool: main.cpp AppleHPMLib.h ssops.h
	$(CXX) $(CXXFLAGS) -o $@ main.cpp $(LDFLAGS)

ifeq ($(PREFIX),)
    PREFIX := /usr/local
endif

INSTALL := /usr/bin/install

.PHONY: install
install: macvdmtool
	@sudo $(INSTALL) -d "$(PREFIX)/bin/"
	@sudo $(INSTALL) -m 755 -o root -g wheel "$(<)" "$(PREFIX)/bin/"

.PHONY: clean
clean:
	rm -f macvdmtool *.o
