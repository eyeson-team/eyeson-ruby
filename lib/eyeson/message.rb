module Eyeson
  # Forward messages to room
  class Message
    class ValidationFailed < StandardError
    end

    def initialize(access_key)
      @access_key = access_key
    end

    def create(type: nil, content: nil)
      response = Eyeson.post("/rooms/#{@access_key}/messages",
                             type: type,
                             content: content)

      raise ValidationFailed, response['error'] if response.key? 'error'
    end
  end
end
