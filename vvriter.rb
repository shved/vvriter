class VVriter < Roda
  plugin :render, engine: 'slim'
  plugin :assets, css: 'all.scss', js: 'all.coffee'
  plugin :public

  route do |r|
    r.assets

    r.on('public') do
      r.public
    end

    r.on ENV['AUTH_KEY'] do
      r.get '' do
        folder = Dropbox.client.list_folder('')
        @names = folder.entries.map(&:name)
        view 'list'
      end

      r.get 'vvrites', String do |vvrite_id|
        # @cards = Dropbox.client.list_folder("/#{vvrite_id}").entries
        # @vvrite_id = vvrite_id
        # view 'editor'
        view inline: '<h1>PIZDEC</h1>'
      end
    end
  end
end
