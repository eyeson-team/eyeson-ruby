# Provides REST methods
module Eyeson
  def post(path, params = {})
    uri = URI.parse("#{configuration.endpoint}#{path}")
    req = Net::HTTP::Post.new(uri)
    req.body = params.to_json
    request(uri, req)
  end
  module_function :post

  def request(uri, req)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    req['Content-Type'] = 'application/json'
    req['Authorization'] = configuration.api_key

    res = http.request(req)
    Rails.logger.info "REQUESTING to #{uri} with #{req.inspect}"
    Rails.logger.info "RESPONSE: #{res.inspect}"
    #return unless res.body.present?
    JSON.parse(res.body)
  end
  module_function :request
end
