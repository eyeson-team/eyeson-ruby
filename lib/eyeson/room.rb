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
      room = Eyeson.post('/rooms',
                         id:   id,
                         name: name,
                         user: mapped_user(user))

      raise ValidationFailed, room['error'] if room['error'].present?
      Room.new(
        url:        room['links']['gui'],
        access_key: room['access_key']
      )
    end

    def self.mapped_user(user)
      {
        id:         user[:email],
        name:       user[:name],
        avatar:     user[:avatar]
      }
    end
  end
end
