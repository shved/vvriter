class VVrite
  def initialize(filename)
    @filename = filename
  end

  def slug
    @slug ||= @filename.gsub(VVriter.config.vvrites_extension, '')
  end

  def title
    @title ||= begin
                 File.open(full_path, &:readline).gsub(/^[\wа-яА-Я]+/, '').strip
               rescue StandardError
                 return nil
               end
  end

  def full_path
    @full_path ||= File.join(Storage::STORAGE_PATH, @filename)
  end
end
