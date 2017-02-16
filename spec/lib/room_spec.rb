require 'spec_helper'

RSpec.describe Eyeson::Internal, type: :class do
  let(:user) do
    {
      id:     Faker::Crypto.md5,
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
    room = Eyeson::Room.new(url: Faker::Internet.url, access_key: '12345')
    expect(room.url).to be_present
    expect(room.access_key).to be_present
  end

  it 'should return room instance after join' do
    expects_api_response_with
    expect(room.url).to be_present
  end

  it 'should raise errors' do
    expects_api_response_with(error: 'some_error')
    expect { room }.to raise_error(Eyeson::Room::ValidationFailed, 'some_error')
  end

  it 'should contain correct user fields in mapped_user' do
    mapped = Eyeson::Room.mapped_user(user)
    expect(mapped[:id]).to eq(user[:email])
    expect(mapped[:name]).to eq(user[:name])
    expect(mapped[:avatar]).to eq(user[:avatar])
  end
end
