module Eyeson
  # Manages conf rooms
  class Room
    class ValidationFailed < StandardError
    end

    attr_reader :url, :access_key, :guest_token

    def initialize(api_key: nil, id: nil, name: nil, user: {})
      @api_key     = api_key
      @id          = id
      @user        = mapped_user(user)
      @name        = name
      @url         = nil
      @access_key  = nil
      @guest_token = nil
      create!
    end

    private

    def create!
      room = Eyeson.post('/rooms',
                         @api_key,
                         id:   @id,
                         name: @name,
                         user: @user)

      raise ValidationFailed, room['error'] if room['error'].present?
      @url         = room['links']['gui']
      @access_key  = room['access_key']
      @guest_token = room['room']['guest_token']
    end

    def mapped_user(user)
      {
        id:         user[:email],
        name:       user[:name],
        avatar:     user[:avatar]
      }
    end
  end
end
