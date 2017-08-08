# Provides REST methods
module Eyeson
  def get(path, params = {})
    request(:get, path, params)
  end
  module_function :get

  def post(path, params = {})
    request(:post, path, params)
  end
  module_function :post

  def delete(path, params = {})
    request(:delete, path, params)
  end
  module_function :delete

  def request(method, path, params)
    req = RestClient::Request.new(
      method: method,
      url: configuration.api_endpoint + path,
      payload: params.compact,
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
    return {} if res.body.blank?
    JSON.parse(res.body)
  end
  module_function :response_for
end
