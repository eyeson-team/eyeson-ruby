module Eyeson
  # Provides access to the internal eyeson api
  module Internal
    def post(path, params = {})
      request(:post, path, params)
    end
    module_function :post

    def request(method, path, params)
      req = RestClient::Request.new(
        method: method,
        url: "#{Eyeson.configuration.api_endpoint}/internal#{path}",
        payload: params,
        headers: { accept: 'application/json' },
        user: Eyeson.configuration.internal_username,
        password: Eyeson.configuration.internal_password
      )
      Eyeson.response_for(req)
    end
    module_function :request
  end
end
