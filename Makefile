default: lint test

install:
	bundle install

test:
	bin/rspec

lint:
	bin/rubocop

console:
	bin/console

run:
	rackup config.ru
