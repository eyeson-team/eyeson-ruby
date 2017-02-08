module Eyeson
  # API configuration class
  class Configuration
    attr_accessor :api_key, :endpoint, :internal_username, :internal_password

    def initialize
      @api_key = ''
      @endpoint = 'https://api.eyeson.team'
      @internal_username = ''
      @internal_password = ''
    end
  end
end
