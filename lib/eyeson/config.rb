module Eyeson
  # API configuration class
  class Configuration
    attr_accessor :api_key, :api_endpoint

    def initialize
      @api_key      = ''
      @api_endpoint = 'https://api.eyeson.team'
    end
  end
end
