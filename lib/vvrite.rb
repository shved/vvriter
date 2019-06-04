class VVrite
  def initialize(filename)
    @filename = filename
  end

  def slug
    @filename.gsub(VVriter.config.vvrites_extension, '')
  end

  def title
    File.open(File.join(Storage::STORAGE_PATH, @filename), &:readline)
  end
end
