require 'spec_helper'

RSpec.describe Eyeson::Intercom, type: :class do
	it 'should use correct config in post' do
		RestClient::Request.expects(:new).with(
      method: :post,
      url: 'https://account.localhost.test/intercom',
      payload: { content: true },
      headers: { authorization: Eyeson.configuration.account_api_key,
                 accept: 'application/json' }
    )
    Eyeson.expects(:response_for)
    Eyeson::Intercom.post(content: true)
	end
end
