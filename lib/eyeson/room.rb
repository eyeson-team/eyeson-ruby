module Eyeson
  # Manages conf rooms
  class Room
    class ValidationFailed < StandardError
    end

    attr_reader :url, :access_key

    def initialize(url: nil, access_key: nil)
      @url        = url
      @access_key = access_key
    end

    def self.join(id: nil, name: nil, user: {})
      response = Eyeson.post('/rooms',
                             id:   id,
                             name: name,
                             user: Account.mapped_user(user))

      raise ValidationFailed, response['error'] if response['error'].present?
      Room.new(
        url:        response['links']['gui'],
        access_key: response['access_key']
      )
    end
  end
end
