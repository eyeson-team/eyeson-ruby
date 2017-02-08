module Eyeson
  # Manages conf rooms
  class Room
    class ValidationFailed < StandardError
    end

    attr_reader :url, :access_key, :guest_token

    def initialize(id: nil, name: nil, user: {})
      @id          = id
      @user        = user
      @team        = user.team
      @name        = name
      @url         = nil
      @access_key  = nil
      @guest_token = nil
      create!
    end

    private

    def create!
      room = Eyeson.post('/rooms',
                         @team.api_key,
                         id:   @id,
                         name: @name,
                         user: mapped_user)

      raise ValidationFailed, room['error'] if room['error'].present?
      @url = room['links']['gui']
      @access_key = room['access_key']
      @guest_token = room['room']['guest_token']
    end

    def mapped_user
      {
        id:         @user.email,
        name:       @user.name,
        avatar:     @user.avatar
      }
    end
  end
end
