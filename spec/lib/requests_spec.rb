require 'spec_helper'

RSpec.describe Eyeson, type: :class do
  it 'should handle JSON response' do
    api_response_with(error: 'some_error')
    expect(Eyeson.post('/test')).kind_of?(JSON)
  end

  it 'should handle empty response' do
    api_response_with(body: false)
    expect(Eyeson.post('/test')).to be_nil
  end
end
