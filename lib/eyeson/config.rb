module Eyeson
  # API configuration class
  class Configuration
    attr_accessor :api_key, :api_endpoint
    attr_accessor :account_endpoint, :account_api_key

    def initialize
      @api_key           = ''
      @api_endpoint      = 'https://api.eyeson.team'
      @account_api_key   = ''
      @account_endpoint  = 'https://account.eyeson.team/api'
    end
  end
end
