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
      headers: { 'Authorization' => configuration.api_key,
                 'Accept' => 'application/json',
                 params: params }
    )
    return unless res.body.present?
    JSON.parse(res.body)
  end
  module_function :request
end
