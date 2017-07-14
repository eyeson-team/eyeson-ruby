module Eyeson
  # Handles eyeson account confirmation
  class Account
    class ValidationFailed < StandardError
    end

    attr_reader :confirmation_url

    def initialize(confirmation_url: nil)
      @confirmation_url = confirmation_url
    end

    def self.find_or_initialize_by(user: {}, remote_ip: nil)
      confirmed = Eyeson.post('/internal/accounts',
                              user: user,
                              remote_ip: remote_ip)
      confirmation_url = confirmed['create_url'] if confirmed.present?
      Account.new(confirmation_url: confirmation_url)
    end

    def new_record?
      @confirmation_url.present?
    end
  end
end
