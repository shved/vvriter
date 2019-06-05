require 'dropbox_api'
require 'dotenv/load' if ENV['RACK_ENV'] != 'production'
require 'roda'
require 'dry-configurable'
require './vvriter'

Dir['./lib/**/*.rb'].each { |file| require file }
