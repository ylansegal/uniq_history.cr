CRYSTAL_BIN ?= $(shell which crystal)
BIN_DIR = bin
EXECUTABLE = uniq_history

test:
	$(CRYSTAL_BIN) spec
build: bin_dir
	$(CRYSTAL_BIN) build --release -o $(BIN_DIR)/$(EXECUTABLE) src/cli.cr $(CRFLAGS)
bin_dir:
	mkdir $(BIN_DIR)
install:
	cp $(BIN_DIR)/$(EXECUTABLE) /usr/local/bin/

.PHONY : clean
clean :
	-rm -rf $(BIN_DIR)
