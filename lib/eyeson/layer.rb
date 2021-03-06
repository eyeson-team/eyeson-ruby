module Eyeson
  # Manages room layers
  class Layer
    class ValidationFailed < StandardError
    end

    def initialize(access_key)
      @access_key = access_key
    end

    def create(file: nil, url: nil, insert: nil, index: 1, layout: nil)
      response = Eyeson.post("/rooms/#{@access_key}/layers",
                             file: file,
                             url: url,
                             insert: insert,
                             'z-index' => index,
                             layout: layout)

      raise ValidationFailed, response['error'] if response.key? 'error'
    end

    def destroy(index: 1, layout: nil)
      Eyeson.delete("/rooms/#{@access_key}/layers/#{index}", layout: layout)
    end
  end
end
