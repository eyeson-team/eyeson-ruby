require 'spec_helper'

RSpec.describe Eyeson::Internal, type: :class do
	it 'should use correct config in post' do
		RestClient::Request.expects(:new).with(
      method: :post,
      url: 'https://api.localhost.test/internal/test',
      payload: {},
      headers: { accept: 'application/json' },
      user: 'user',
      password: 'pwd'
    )
    Eyeson.expects(:response_for)
    Eyeson::Internal.post('/test')
	end
end
