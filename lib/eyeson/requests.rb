# Provides REST methods
module Eyeson
  def post(path, params = {})
    request(:post, path, params)
  end
  module_function :post

  def request(method, path, params)
    res = RestClient::Request.execute(
      method: method,
      url: configuration.endpoint + path,
      payload: params,
      headers: { authorization: configuration.api_key,
                 accept: 'application/json' }
    )
    return unless res.body.present?
    JSON.parse(res.body)
  end
  module_function :request
end
