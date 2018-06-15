crystal ?= $(shell which crystal)
shards ?= $(shell which shards)
bin_dir = bin
doc_dir = doc
executable = uniq_history

test: dependencies
	$(crystal) spec
build: bin_directory dependencies
	$(crystal) build --release -o $(bin_dir)/$(executable) src/cli.cr $(CRFLAGS)
bin_directory:
	mkdir -p $(bin_dir)
dependencies:
	$(shards) install
install: build
	cp $(bin_dir)/$(executable) /usr/local/bin/
docs: build
	$(crystal) docs

.PHONY : clean
clean :
	-rm -rf $(bin_dir) $(doc_dir)
