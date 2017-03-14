module Eyeson
  # Handles eyeson account confirmation
  class Account
    class ValidationFailed < StandardError
    end

    attr_reader :confirmation_url

    def initialize(confirmation_url: nil)
      @confirmation_url = confirmation_url
    end

    def self.find_by(email: nil)
      confirmed = confirmed?(email)
      confirmation_url = confirmed['create_url'] if confirmed.present?
      Account.new(confirmation_url: confirmation_url)
    end

    def present?
      @confirmation_url.nil?
    end

    def self.confirmed?(email)
      url = "#{Eyeson.configuration.account_endpoint}/confirmation"
      req = RestClient::Request.new(
        method: :get,
        url: "#{url}?user[email]=#{CGI.escape(email)}",
        headers: { accept: 'application/json' },
        user: Eyeson.configuration.internal_username,
        password: Eyeson.configuration.internal_password
      )
      Eyeson.response_for(req)
    end
  end
end
