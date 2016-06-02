crystal ?= $(shell which crystal)
bin_dir = bin
executable = uniq_history

test: dependencies
	$(crystal) spec
build: bin_directory dependencies
	$(crystal) build --release -o $(bin_dir)/$(executable) src/cli.cr $(CRFLAGS)
bin_directory:
	mkdir -p $(bin_dir)
dependencies:
	$(crystal) deps
install:
	cp $(bin_dir)/$(executable) /usr/local/bin/

.PHONY : clean
clean :
	-rm -rf $(bin_dir)
