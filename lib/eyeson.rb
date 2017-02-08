# Eyeson API
module Eyeson
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def post(path, api_key, params = {})
    uri = URI.parse("#{configuration.endpoint}#{path}")
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

require_relative 'eyeson/config'
require_relative 'eyeson/internal'
require_relative 'eyeson/api_key'
require_relative 'eyeson/room'
require_relative 'eyeson/file_upload'
