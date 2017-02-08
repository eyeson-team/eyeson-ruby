module Eyeson
  module ApiHelpers
    def uses_internal_api
      expect(Eyeson.configuration.internal_username).to be_present
      expect(Eyeson.configuration.internal_password).to be_present
      req = mock('REST Request')
      req.expects(:basic_auth).with(
        Eyeson.configuration.internal_username,
        Eyeson.configuration.internal_password
      )
      req.expects(:[]=).once
      req.expects(:body=).once
      Net::HTTP::Post.expects(:new).returns(req)
    end
    module_function :uses_internal_api

    def api_response_with(
        error: nil,
        api_key: Faker::Crypto.md5,
        access_key: Faker::Crypto.md5,
        guest_token: Faker::Crypto.md5,
        gui: 'gui_url'
    )

      res = mock('Eyeson result', body: {
        error: error,
        api_key: api_key,
        access_key: access_key,
        room: { guest_token: guest_token },
        links: { gui: gui }
      }.to_json)

      req = mock('Eyeson Request')
      req.expects(:use_ssl=).at_least_once
      req.expects(:verify_mode=).at_least_once
      req.expects(:request).returns(res).at_least_once
      Net::HTTP.expects(:new).returns(req).at_least_once
    end
    module_function :api_response_with
  end
end