require 'spec_helper'

RSpec.describe Eyeson::ApiKey, type: :class do
  it 'should create api key' do
    expects_internal_api_response_with(api_key: '123')

    api = Eyeson::ApiKey.create!(name: Faker::Team.name, email: Faker::Internet.email)
    expect(api.key).to eq('123')
  end

  it 'should raise errors' do
    expects_internal_api_response_with(error: 'some_error')
    expect { Eyeson::ApiKey.create!(name: Faker::Team.name, email: Faker::Internet.email) }
      .to raise_error(Eyeson::ApiKey::ValidationFailed, 'some_error')
  end

  it 'should provide a webhook instance' do
    key = '12345'
    api = Eyeson::ApiKey.new(key)
    Eyeson::Webhook.expects(:new).with(key)
    expect(api.webhooks).kind_of?(Eyeson::Webhook)
  end
end
