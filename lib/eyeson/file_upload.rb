require 'open-uri'

module Eyeson
  # Manages file uploads
  class FileUpload
    class ValidationFailed < StandardError
    end

    attr_accessor :file

    def initialize(access_key)
      @access_key = access_key
      @file       = nil
    end

    def upload_from(url)
      Tempfile.class_eval do
        attr_accessor :original_filename
      end

      url = URI(url)
      @file = OpenURI.open_uri url
      @file.original_filename = File.basename url.path

      upload!
    end

    private

    def upload!
      response = Eyeson.post("/rooms/#{@access_key}/files", file: @file)
      raise ValidationFailed, response['error'] if response.key? 'error'
    end
  end
end
