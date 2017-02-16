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
      team = Internal.post('/teams',
                           email:   email,
                           name:    name,
                           company: company)
      raise ValidationFailed, team['error'] if team['error'].present?
      ApiKey.new(team['api_key'])
    end
  end
end
