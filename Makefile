default: lint

install:
	bundle install

lint:
	bin/rubocop

console:
	bin/console

run:
	rackup config.ru
