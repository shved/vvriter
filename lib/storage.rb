class Storage
  STORAGE_PATH = File.join(VVriter.config.root, 'vvrites').freeze

  class << self
    def sync
      clean

      folder = Dropbox.client.list_folder('')

      folder.entries.each do |entry|
        next if entry.to_hash['.tag'] != 'file'
        next if File.extname(entry.name) != VVriter.config.vvrites_extension

        sync_entry(entry)
      end
    end

    def clean
      Dir.foreach(STORAGE_PATH) do |f|
        next unless File.extname(f) == VVriter.config.vvrites_extension

        File.delete(File.join(STORAGE_PATH, f))
      end
    end

    def sync_entry(entry)
      path = build_path(entry)
      file = File.new(path, 'w')

      Dropbox.client.download(entry.path_lower) do |data|
        file.write data
      end

      file.close
    end

    def build_path(entry)
      # join filename with content hashsum to make sure heroku or browsers wont cache updated texts
      hashed_name = entry.name.split('.').join("-#{entry.content_hash[0..7]}.")
      File.join(STORAGE_PATH, hashed_name)
    end
  end
end
