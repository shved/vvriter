# frozen_string_literal: true

class VVriter < Roda
  extend Dry::Configurable
  setting :root
  setting :dropbox_token
  setting :vvrites_extension
  setting :auth_key

  configure do |config|
    config.root = __dir__
    config.dropbox_token = ENV['DROPBOX_TOKEN']
    config.vvrites_extension = '.slim'
    config.auth_key = ENV['AUTH_KEY']
  end

  plugin :render, engine: 'slim'
  plugin :assets, css: 'all.scss', js: 'all.coffee'
  plugin :public

  route do |r|
    r.assets

    r.on('public') do
      r.public
    end

    r.on self.class.config.auth_key do
      r.get '' do
        @vvrites = []

        Dir.children(Storage::STORAGE_PATH).each do |filename|
          next if File.extname(filename) != VVriter.config.vvrites_extension

          @vvrites << VVrite.new(filename)
        end

        view 'list'
      end

      r.post '/sync' do
        Storage.sync
        r.redirect
      end

      r.get 'vvrites', String do |_vvrite_id|
        view inline: '<h1>PIZDEC</h1>'
      end
    end
  end
end
