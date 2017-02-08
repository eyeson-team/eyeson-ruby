module Eyeson
  # Provides access to the internal eyeson api
  module Internal
    def post(path, params = {})
      uri = URI.parse("#{Eyeson.configuration.endpoint}/internal#{path}")
      req = Net::HTTP::Post.new(uri)
      req.body = params.to_json
      request(uri, req)
    end
    module_function :post

    def request(uri, req)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      req.basic_auth(Eyeson.configuration.internal_username,
                     Eyeson.configuration.internal_password)
      req['Content-Type'] = 'application/json'

      res = http.request(req)
      return unless res.body.present?
      JSON.parse(res.body)
    end
    module_function :request
  end
end
