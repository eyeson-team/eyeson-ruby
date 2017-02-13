require 'spec_helper'

RSpec.describe Eyeson::Configuration, type: :class do
  it 'should have default configuration' do
    expect(Eyeson.configuration).to be_present
    expect(Eyeson.configuration.endpoint).to eq('https://api.eyeson.team')
  end

  it 'should be configurable' do
    Eyeson.configure do |config|
      config.api_key = '123'
    end
    expect(Eyeson.configuration.api_key).to eq('123')
  end
end
