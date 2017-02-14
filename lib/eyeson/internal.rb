module Eyeson
  # Provides access to the internal eyeson api
  module Internal
    def post(path, params = {})
      request(:post, path, params)
    end
    module_function :post

    def request(method, path, params)
      res = RestClient::Request.execute(
        method: method,
        url: "#{Eyeson.configuration.endpoint}/internal#{path}",
        payload: params,
        headers: { accept: 'application/json' },
        user: Eyeson.configuration.internal_username,
        password: Eyeson.configuration.internal_password
      )
      return unless res.body.present?
      JSON.parse(res.body)
    end
    module_function :request
  end
end
