module Eyeson
  # Provides access to the eyeson Intercom api
  module Intercom
    def post(params = {})
      req = RestClient::Request.new(
        method: :post,
        url: "#{Eyeson.configuration.account_endpoint}/intercom",
        payload: params,
        headers: { authorization: Eyeson.configuration.account_api_key,
                   accept: 'application/json' }
      )
      Eyeson.response_for(req)
    end
    module_function :post
  end
end
