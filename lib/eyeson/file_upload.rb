module Eyeson
  # Manages conf rooms
  class FileUpload
    class ValidationFailed < StandardError
    end

    attr_accessor :file

    def initialize(access_key)
      @access_key = access_key
      @file       = nil
    end

    def upload_from(url)
      @file = download_from(url)
      upload!
    end

    private

    def download_from(url)
      uri = URI.parse(url)
      Net::HTTP.start(uri.host, uri.port) do |http|
        resp = http.get(uri.path)
        file = Tempfile.new('presentation')
        file.binmode
        file.write(resp.body)
        file.flush
        file
      end
    end

    def upload!
      upload = Eyeson.post("/rooms/#{@access_key}/files",
                           file: @file)

      raise ValidationFailed, upload['error'] if upload['error'].present?
    end
  end
end
