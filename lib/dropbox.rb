class Dropbox
  def self.client
    @client ||= DropboxApi::Client.new(ENV['DROPBOX_TOKEN'])
  end
end
