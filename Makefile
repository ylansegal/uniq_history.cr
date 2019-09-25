crystal ?= $(shell which crystal)
shards ?= $(shell which shards)

test: shard.lock
	$(crystal) spec --warnings all --error-on-warnings

bin/uniq_history: bin shard.lock src/**/*.cr src/*.cr
	$(crystal) build --release --no-debug -o bin/uniq_history src/cli.cr $(CRFLAGS)

bin:
	mkdir -p bin

shard.lock: shard.yml
	$(shards) prune
	$(shards) install
	touch $@

install: /usr/local/bin/uniq_history

/usr/local/bin/uniq_history: bin/uniq_history
	cp bin/uniq_history /usr/local/bin/

clean :
	-rm -rf bin

.PHONY : clean install test
