module Eyeson
  # API configuration class
  class Configuration
    attr_accessor :api_key, :api_endpoint
    attr_accessor :account_endpoint, :internal_username, :internal_password

    def initialize
      @api_key           = ''
      @api_endpoint      = 'https://api.eyeson.team'
      @account_endpoint  = 'https://account.eyeson.team/api'
      @internal_username = ''
      @internal_password = ''
    end
  end
end
