module Eyeson
  # Creates Webhooks
  class Webhook
    class ValidationFailed < StandardError
    end

    def initialize(api_key)
      Eyeson.configuration.api_key = api_key
    end

    def create!(url: nil, types: [])
      webhook = Eyeson.post('/webhooks',
                            url: url,
                            types: types.join(','))
      raise ValidationFailed, webhook['error'] if webhook['error'].present?
    end
  end
end
