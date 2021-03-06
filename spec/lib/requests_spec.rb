require 'spec_helper'

RSpec.describe Eyeson, type: :class do
  it 'should use correct config in post' do
    RestClient::Request.expects(:new).with(
      method: :post,
      url: 'https://api.localhost.test/test',
      payload: {},
      headers: {
        authorization: '123',
        accept: 'application/json',
        user_agent: 'eyeson-ruby'
      }
    )
    Eyeson.expects(:response_for)
    Eyeson.post('/test')
  end

  it 'should execute request in response_for method' do
    body = { field: 'value' }.to_json
    res = mock('Response')
    res.expects(:body).returns(body).times 3
    req = mock('Request', execute: res)
    JSON.expects(:parse).with(body)
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
    expect(Eyeson.post('/test')).to eq({})
  end

  it 'should provide a get method' do
    Eyeson.expects(:request).with(:get, '/test', {})
    Eyeson.get('/test')
  end

  it 'should provide a get method' do
    Eyeson.expects(:request).with(:post, '/test', { test: true })
    Eyeson.post('/test', { test: true })
  end

  it 'should provide a get method' do
    Eyeson.expects(:request).with(:delete, '/test', {})
    Eyeson.delete('/test')
  end
end
