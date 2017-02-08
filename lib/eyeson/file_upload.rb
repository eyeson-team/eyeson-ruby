module Eyeson
  # Manages conf rooms
  class FileUpload
    class ValidationFailed < StandardError
    end

    def initialize(access_key, url)
      @access_key = access_key
      Thread.new do
        @file = download_from(url)
        upload!
      end.join
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
      file = Eyeson.post("/rooms/#{@access_key}/files",
                         nil,
                         file: @file)

      raise ValidationFailed, file['error'] if file['error'].present?
    end
  end
end
