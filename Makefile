CRYSTAL_BIN ?= $(shell which crystal)

test:
	$(CRYSTAL_BIN) spec
bin:
	mkdir bin
build: bin
	$(CRYSTAL_BIN) build --release -o bin/uniq_history src/cli.cr $(CRFLAGS)
install:
	cp bin/uniq_history /usr/local/bin/
clean:
	rm -rf bin
