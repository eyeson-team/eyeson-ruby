module Eyeson
  # Get room recordings
  class Recording
    class NotFound < StandardError
    end

    attr_reader :id, :url

    def initialize(id, url)
      @id = id
      @url = url
    end

    def self.find(recording_id)
      response  = Eyeson.get "/recordings/#{recording_id}"
      links     = response['links']
      raise NotFound if links.nil?
      Recording.new recording_id, links['download']
    end

    def delete
      Eyeson.delete "/recordings/#{id}"
    end
  end
end
