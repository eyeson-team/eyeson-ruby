module Eyeson
  module ApiHelpers
    def expects_internal_api_response_with(
      api_key: Faker::Crypto.md5,
      error: nil
    )
      Eyeson.expects(:response_for)
            .returns({
              'api_key' => api_key,
              'error'   => error
            })
    end
    module_function :expects_internal_api_response_with

    def expects_api_response_with(
        body: true,
        error: nil,
        access_key: Faker::Crypto.md5,
        guest_token: Faker::Crypto.md5,
        gui: 'gui_url'
    )

      Eyeson.expects(:response_for).returns(body ? {
        'error' => error,
        'access_key' => access_key,
        'room' => { 'guest_token' => guest_token },
        'links' => { 'gui' => gui }
      } : nil)
    end
    module_function :expects_api_response_with
  end
end
