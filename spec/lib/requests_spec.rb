require 'spec_helper'

RSpec.describe Eyeson, type: :class do
	it 'should use correct config in post' do
		RestClient::Request.expects(:execute).with(
      method: :post,
      url: 'https://api.eyeson.team/test',
      payload: {},
      headers: {
        authorization: '123',
        accept: 'application/json'
      }
    ).returns(mock('Response', body: {}))
    Eyeson.post('/test')
	end

  it 'should handle JSON response' do
    expects_api_response_with(error: 'some_error')
    expect(Eyeson.post('/test')).kind_of?(JSON)
  end

  it 'should handle empty response' do
    expects_api_response_with(body: false)
    expect(Eyeson.post('/test')).to be_nil
  end
end
