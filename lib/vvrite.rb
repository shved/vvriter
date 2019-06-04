# frozen_string_literal: true

class VVrite
  def initialize(filename)
    @filename = filename
  end

  def slug
    @slug ||= @filename.gsub(VVriter.config.vvrites_extension, '')
  end

  def title
    @title ||= File.open(full_path, &:readline)
  end

  def full_path
    @full_path ||= File.join(Storage::STORAGE_PATH, @filename)
  end
end
