module Eyeson
  # Generates individual API key for each team
  class ApiKey
    class ValidationFailed < StandardError
    end

    attr_reader :key

    def initialize(name: nil, email: nil, company: nil)
      @name    = name
      @email   = email
      @company = company
      @key     = nil
      create!
    end

    private

    def create!
      team = Internal.post('/teams',
                           email:   @email,
                           name:    @name,
                           company: @company)
      raise ValidationFailed, team['error'] if team['error'].present?
      @key = team['api_key']
    end
  end
end
