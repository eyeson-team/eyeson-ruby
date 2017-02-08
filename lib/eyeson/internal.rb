module Eyeson
  # provides access to the internal eyeson api
  module Internal
    USERNAME = Rails.application.secrets.internal_api_username.freeze
    PASSWORD = Rails.application.secrets.internal_api_password.freeze

    def post(path, params = {})
      uri = URI.parse("#{API_URL}/internal#{path}")
      req = Net::HTTP::Post.new(uri)
      req.body = params.to_json
      request(uri, req)
    end
    module_function :post

    def request(uri, req)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      req.basic_auth USERNAME, PASSWORD
      req['Content-Type'] = 'application/json'

      res = http.request(req)
      JSON.parse(res.body)
    end
    module_function :request
  end
end
