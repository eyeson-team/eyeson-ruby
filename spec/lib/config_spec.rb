require 'spec_helper'

RSpec.describe Eyeson::Configuration, type: :class do
  it 'should have default configuration' do
    expect(Eyeson.configuration).to be_present
    expect(Eyeson.configuration.api_endpoint).to eq('https://api.eyeson.team')
  end

  it 'should be configurable' do
    Eyeson.configure do |config|
      config.api_key           = '123'
      config.api_endpoint      = 'https://api.localhost.test'
      config.account_endpoint  = 'https://account.localhost.test'
    end
    expect(Eyeson.configuration.api_key).to eq('123')
    expect(Eyeson.configuration.api_endpoint).to eq('https://api.localhost.test')
    expect(Eyeson.configuration.account_endpoint).to eq('https://account.localhost.test')
  end
end
