require 'spec_helper'

RSpec.describe Eyeson::ApiKey, type: :class do
  it 'creates api key after initialization' do
    uses_internal_api
    api_response_with(api_key: '123')

    api = Eyeson::ApiKey.new(name: Faker::Team.name, email: Faker::Internet.email)
    expect(api.key).to eq('123')
  end

  it 'raises errors' do
    uses_internal_api
    api_response_with(error: 'some_error')
    expect { Eyeson::ApiKey.new(name: Faker::Team.name, email: Faker::Internet.email) }
      .to raise_error(Eyeson::ApiKey::ValidationFailed, 'some_error')
  end

  it 'uses basic auth for internal api' do
    uses_internal_api
    api_response_with
    Eyeson::ApiKey.new(name: Faker::Team.name, email: Faker::Internet.email)
  end
end
