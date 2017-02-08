module Eyeson
	# API configuration class
	class Configuration
    attr_accessor :endpoint, :internal_username, :internal_password

    def initialize
      @endpoint = 'https://api.eyeson.team'
      @internal_username = ''
      @internal_password = ''
    end
  end
end