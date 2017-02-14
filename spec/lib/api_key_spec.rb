require 'spec_helper'

RSpec.describe Eyeson::ApiKey, type: :class do
  it 'should create api key after initialization' do
    expects_internal_api_response_with(api_key: '123')

    api = Eyeson::ApiKey.new(name: Faker::Team.name, email: Faker::Internet.email)
    expect(api.key).to eq('123')
  end

  it 'should raise errors' do
    expects_internal_api_response_with(error: 'some_error')
    expect { Eyeson::ApiKey.new(name: Faker::Team.name, email: Faker::Internet.email) }
      .to raise_error(Eyeson::ApiKey::ValidationFailed, 'some_error')
  end
end
