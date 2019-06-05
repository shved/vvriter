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
  plugin :public

  route do |r|
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

      r.get String do |vvrite_slug|
        filename = vvrite_slug.concat(VVriter.config.vvrites_extension)
        view_path = File.join(Storage::STORAGE_PATH, filename)
        view path: view_path
      end

      r.post '' do
        Storage.sync
        r.redirect
      end
    end
  end
end
