# Provides REST methods
module Eyeson
  def post(path, params = {})
    request(:post, path, params)
  end
  module_function :post

  def request(method, path, params)
    req = RestClient::Request.new(
      method: method,
      url: configuration.api_endpoint + path,
      payload: params,
      headers: { authorization: configuration.api_key,
                 accept: 'application/json' }
    )
    response_for(req)
  end
  module_function :request

  def response_for(req)
    res = begin
      req.execute
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
    return unless res.body.present?
    JSON.parse(res.body)
  end
  module_function :response_for
end
