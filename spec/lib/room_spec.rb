require 'spec_helper'

RSpec.describe Eyeson::Room, type: :class do
  let(:user) do
    {
      email:  Faker::Internet.email,
      name:   Faker::Name.name,
      avatar: Faker::Internet.url
    }
  end
  let(:room) do
    Eyeson::Room.join(
      id:   Faker::Crypto.md5,
      name: Faker::Team.name,
      user: user
    )
  end

  it 'should set acccessor variables after initialization' do
    response = {
      access_key: '12345',
      links: {
        gui: Faker::Internet.url
      }
    }.to_json
    room = Eyeson::Room.new(response)
    expect(room.url).to        eq(response['links']['gui'])
    expect(room.access_key).to eq(response['access_key'])
    expect(room.links).to      eq(response['links'])
  end

  it 'should return room instance after join' do
    expects_api_response_with
    expect(room.url).to be_present
  end

  it 'should raise errors' do
    expects_api_response_with(error: 'some_error')
    expect { room }.to raise_error(Eyeson::Room::ValidationFailed, 'some_error')
  end
end
