module Eyeson
  # Manages conf rooms
  class Room
    class ValidationFailed < StandardError
    end

    attr_reader :url, :access_key, :links

    def initialize(response = {})
      @url        = response['links']['gui']
      @access_key = response['access_key']
      @links      = response['links']
    end

    def self.join(id: nil, name: nil, user: {}, options: nil)
      response = Eyeson.post('/rooms',
                             id:      id,
                             name:    name,
                             user:    user,
                             options: options)

      raise ValidationFailed, response['error'] unless response['error'].nil?
      Room.new(response)
    end
  end
end
