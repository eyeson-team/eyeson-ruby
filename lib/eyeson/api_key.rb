module Eyeson
  # Generates individual API key for each team
  class ApiKey
    class ValidationFailed < StandardError
    end

    attr_reader :key

    def initialize(key)
      @key = key
    end

    def self.create!(name: nil, email: nil, company: nil)
      team = post('/teams',
                  email:   email,
                  name:    name,
                  company: company)
      raise ValidationFailed, team['error'] if team['error'].present?
      ApiKey.new(team['api_key'])
    end

    def webhooks
      Webhook.new(@key)
    end

    private

    def self.post(path, params)
      req = RestClient::Request.new(
        method: :post,
        url: "#{Eyeson.configuration.api_endpoint}/internal#{path}",
        payload: params,
        headers: { accept: 'application/json' },
        user: Eyeson.configuration.internal_username,
        password: Eyeson.configuration.internal_password
      )
      Eyeson.response_for(req)
    end
  end
end
