require 'spec_helper'

RSpec.describe Eyeson::Message, type: :class do

  let(:message) do
    Eyeson::Message.new('access_key')
  end

  it 'should post a message to room' do
    Eyeson.expects(:post).with('/rooms/access_key/messages',
                                type:    'chat',
                                content: 'message').returns({})
    message.create(type: 'chat', content: 'message')
  end

  it 'should raise errors' do
    expects_api_response_with(error: 'some_error')
    expect { message.create }.to raise_error(Eyeson::Message::ValidationFailed, 'some_error')
  end
end
