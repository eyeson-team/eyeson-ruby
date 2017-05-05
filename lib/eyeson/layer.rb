module Eyeson
  # Manages room layers
  class Layer
    class ValidationFailed < StandardError
    end

    def initialize(access_key)
      @access_key = access_key
    end

    def create(file: nil, url: nil, index: 1, layout: nil)
      upload = Eyeson.post(
        "/rooms/#{@access_key}/layers",
        file: file,
        url: url,
        'z-index' => index,
        layout: layout
      )
      raise ValidationFailed, upload['error'] if upload['error'].present?
    end

    def destroy(index: 1)
      Eyeson.delete("/rooms/#{@access_key}/layers/#{index}")
    end
  end
end
