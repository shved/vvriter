# frozen_string_literal: true

class Storage
  STORAGE_PATH = File.join(VVriter.config.root, 'vvrites').freeze

  class << self
    def sync
      clean

      folder = Dropbox.client.list_folder('')

      folder.entries.each do |en|
        sync_entry(en)
      end
    end

    def clean
      Dir.foreach(STORAGE_PATH) do |f|
        next unless File.extname(f) == VVriter.config.vvrites_extension

        File.delete(File.join(STORAGE_PATH, f))
      end
    end

    def sync_entry(entry)
      return if entry.to_hash['.tag'] != 'file'
      return if File.extname(entry.name) != VVriter.config.vvrites_extension

      path = File.join(STORAGE_PATH, entry.name)
      file = File.new(path, 'w')

      Dropbox.client.download(entry.path_lower) do |data|
        file.write data
      end

      file.close
    end
  end
end
