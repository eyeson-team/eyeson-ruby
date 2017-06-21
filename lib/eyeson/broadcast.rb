module Eyeson
  # Manages room broadcast
  class Broadcast
    class ValidationFailed < StandardError
    end

    def initialize(access_key)
      @access_key = access_key
    end

    def create(platform: nil, stream_url: nil)
      response = Eyeson.post("/rooms/#{@access_key}/broadcasts",
                             platform:   platform,
                             stream_url: stream_url)

      raise ValidationFailed, response['error'] if response['error'].present?
    end

    def destroy(platform: nil)
      Eyeson.delete("/rooms/#{@access_key}/broadcasts/#{platform}")
    end

    def destroy_all
      Eyeson.delete("/rooms/#{@access_key}/broadcasts")
    end
  end
end
