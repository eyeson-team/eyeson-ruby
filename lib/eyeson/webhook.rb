module Eyeson
  # Creates Webhooks
  class Webhook
    class ValidationFailed < StandardError
    end

    def self.create!(url: nil, types: [])
      webhook = Eyeson.post('/webhooks',
                            url: url,
                            types: types.join(','))
      raise ValidationFailed, webhook['error'] if webhook['error'].present?
    end
  end
end
