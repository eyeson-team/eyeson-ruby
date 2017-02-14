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
    Eyeson::Room.new(
      id:   Faker::Crypto.md5,
      name: Faker::Team.name,
      user: user
    )
  end

  it 'should set acccessor variables after initialization' do
    expects_api_response_with
    expect(room.url).to be_present
    expect(room.access_key).to be_present
    expect(room.guest_token).to be_present
  end

  it 'should raise errors' do
    expects_api_response_with(error: 'some_error')
    expect { room }.to raise_error(Eyeson::Room::ValidationFailed, 'some_error')
  end

  it 'should contain correct user fields in mapped_user' do
    expects_api_response_with
    mapped = room.send(:mapped_user, user)
    expect(mapped[:id]).to eq(user[:email])
    expect(mapped[:name]).to eq(user[:name])
    expect(mapped[:avatar]).to eq(user[:avatar])
  end
end
