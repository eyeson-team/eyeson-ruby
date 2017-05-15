require 'spec_helper'

RSpec.describe Eyeson::Broadcast, type: :class do

  let(:broadcast) do
    Eyeson::Broadcast.new('access_key')
  end

  let(:stream_url) do
    Faker::Internet.url
  end

  it 'should start a specific platform' do
    Eyeson.expects(:post).with('/rooms/access_key/broadcasts',
                                stream_url: stream_url,
                                platform: 'facebook').returns({})
    broadcast.create(platform: 'facebook', stream_url: stream_url)
  end

  it 'should stop a specific platform' do
    url = Faker::Internet.url
    Eyeson.expects(:delete).with('/rooms/access_key/broadcasts/facebook').returns({})
    broadcast.destroy(platform: 'facebook')
  end

  it 'should stop all broadcasts' do
    url = Faker::Internet.url
    Eyeson.expects(:delete).with('/rooms/access_key/broadcasts').returns({})
    broadcast.destroy_all
  end

  it 'should raise errors' do
    expects_api_response_with(error: 'some_error')
    expect { broadcast.create }.to raise_error(Eyeson::Broadcast::ValidationFailed, 'some_error')
  end
end
