module Eyeson
  # Creates Webhooks
  class Webhook
    class ValidationFailed < StandardError
    end

    def self.create!(url: nil, types: [])
      response = Eyeson.post('/webhooks',
                             url: url,
                             types: types.join(','))
      raise ValidationFailed, response['error'] if response.key? 'error'
    end
  end
end
