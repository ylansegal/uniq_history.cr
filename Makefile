crystal ?= $(shell which crystal)
shards ?= $(shell which shards)d

.PHONY : test
test: shard.lock
	$(crystal) spec
bin/uniq_history: bin shard.lock src/**/*.cr
	$(crystal) build --release --no-debug -o bin/uniq_history src/cli.cr $(CRFLAGS)
bin:
	mkdir -p bin
shard.lock: shard.yml
	$(shards) prune
	$(shards) install
	touch $@

.PHONY : install
install: /usr/local/bin/uniq_history
/usr/local/bin/uniq_history: bin/uniq_history
	cp bin/uniq_history /usr/local/bin/

.PHONY : clean
clean :
	-rm -rf bin
