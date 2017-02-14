require 'spec_helper'

RSpec.describe Eyeson::Internal, type: :class do
	it 'should use correct config in post' do
		RestClient::Request.expects(:execute).with(
      method: :post,
      url: 'https://api.eyeson.team/internal/test',
      headers: {
        'Accept' => 'application/json',
        params: {}
      },
      user: '',
      password: ''
    ).returns(mock('Response', body: {}))
    Eyeson::Internal.post('/test')
	end

  it 'should handle JSON response' do
    expects_api_response_with(error: 'some_error')
    expect(Eyeson::Internal.post('/test')).kind_of?(JSON)
  end

  it 'should handle empty response' do
    expects_api_response_with(body: false)
    expect(Eyeson::Internal.post('/test')).to be_nil
  end
end
