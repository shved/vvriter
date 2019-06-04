# frozen_string_literal: true

require 'dropbox_api'
require 'dotenv/load'
require 'roda'
require 'dry-configurable'
require './vvriter'

Dir['./lib/**/*.rb'].each { |file| require file }
