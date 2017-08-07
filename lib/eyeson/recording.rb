module Eyeson
  # Get room recordings
  class Recording
    class NotFound < StandardError
    end

    attr_reader :url

    def initialize(url)
      @url = url
    end

    def self.find(recording_id)
      response  = Eyeson.get("/recordings/#{recording_id}")
      links     = response['links']
      raise NotFound if links.nil?
      Recording.new(links['download'])
    end
  end
end
