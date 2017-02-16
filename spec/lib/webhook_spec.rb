require 'spec_helper'

RSpec.describe Eyeson::Webhook, type: :class do
  let(:webhook) do
    Eyeson::Webhook.new('12345')
  end

  it 'should create webhook' do
    url   = Faker::Internet.url
    types = %w(type1, type2)
    Eyeson.expects(:post).with('/webhooks',
                                url: url,
                                types: types.join(","))
                         .returns({})
    webhook.create!(url: url, types: types)
  end

  it 'should raise errors' do
    expects_api_response_with(error: 'some_error')
    expect { webhook.create! }
      .to raise_error(Eyeson::Webhook::ValidationFailed, 'some_error')
  end
end
