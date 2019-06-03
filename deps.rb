require 'dropbox_api'
require 'dotenv/load'
require 'roda'

Dir['./lib/**/*.rb'].each { |file| require file }
