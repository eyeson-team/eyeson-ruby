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
      @file = open(url)
      upload!
      @file.unlink
    end

    private

    def upload!
      upload = Eyeson.post("/rooms/#{@access_key}/files", file: @file)
      raise ValidationFailed, upload['error'] if upload['error'].present?
    end
  end
end
