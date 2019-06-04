# frozen_string_literal: true

class Dropbox
  def self.client
    @client ||= DropboxApi::Client.new(VVriter.config.dropbox_token)
  end
end
