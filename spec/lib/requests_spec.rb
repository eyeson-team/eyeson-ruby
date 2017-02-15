require 'spec_helper'

RSpec.describe Eyeson, type: :class do
	it 'should use correct config in post' do
		RestClient::Request.expects(:new).with(
      method: :post,
      url: 'https://api.eyeson.team/test',
      payload: {},
      headers: {
        authorization: '123',
        accept: 'application/json'
      }
    )
    Eyeson.expects(:response_for)
    Eyeson.post('/test')
	end

  it 'should execute request in response_for method' do
    res = mock('Response', body: nil)
    req = mock('Request', execute: res)
    Eyeson.response_for(req)
  end

  it 'should handle exceptions in response_for method' do
    error = mock('Error', body: nil)
    req = mock('Request')
    req.expects(:execute).raises(RestClient::ExceptionWithResponse, error)
    Eyeson.response_for(req)
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
