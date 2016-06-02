CRYSTAL_BIN ?= $(shell which crystal)
BIN_DIR = bin
EXECUTABLE = uniq_history

test: dependencies
	$(CRYSTAL_BIN) spec
build: bin_dir dependencies
	$(CRYSTAL_BIN) build --release -o $(BIN_DIR)/$(EXECUTABLE) src/cli.cr $(CRFLAGS)
bin_dir:
	mkdir -p $(BIN_DIR)
dependencies:
	$(CRYSTAL_BIN) deps
install:
	cp $(BIN_DIR)/$(EXECUTABLE) /usr/local/bin/

.PHONY : clean
clean :
	-rm -rf $(BIN_DIR)
