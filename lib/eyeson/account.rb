module Eyeson
  # Handles eyeson account confirmation
  class Account
    class ValidationFailed < StandardError
    end

    attr_reader :confirmation_url

    def initialize(confirmation_url: nil)
      @confirmation_url = confirmation_url
    end

    def self.find_or_initialize_by(user: {})
      confirmed = confirmed?(user: user)
      confirmation_url = confirmed['create_url'] if confirmed.present?
      Account.new(confirmation_url: confirmation_url)
    end

    def new_record?
      @confirmation_url.present?
    end

    def self.confirmed?(user: {})
      url = "#{Eyeson.configuration.account_endpoint}/confirmation"
      req = RestClient::Request.new(
        method: :get,
        url: url,
        headers: { authorization: Eyeson.configuration.account_api_key,
                   accept: 'application/json',
                   params: { user: user } }
      )
      Eyeson.response_for(req)
    end
  end
end
