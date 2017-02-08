# Eyeson API
module Eyeson
  API_URL = Rails.configuration.services['eyeson_api']

  def post(path, api_key, params = {})
    uri = URI.parse("#{API_URL}#{path}")
    req = Net::HTTP::Post.new(uri)
    req.body = params.to_json
    request(uri, api_key, req)
  end
  module_function :post

  def request(uri, api_key, req)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    req['Content-Type'] = 'application/json'
    req['Authorization'] = api_key

    res = http.request(req)
    JSON.parse(res.body)
  end
  module_function :request
end

require_relative 'api/internal'
require_relative 'api/api_key'
require_relative 'api/room'
require_relative 'api/file_upload'
