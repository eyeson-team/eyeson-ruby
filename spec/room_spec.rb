require 'rails_helper'

RSpec.describe Eyeson::Room, type: :class do
  let(:user) do
    create(:user)
  end
  let(:room) do
    channel = build(:channel)
    Eyeson::Room.new(
      id: channel.external_id,
      name: channel.name,
      user:    user
    )
  end

  it 'gets and sets url after initialization' do
    api_response_with
    expect(room.url).to eq('gui_url')
  end

  it 'raises errors' do
    api_response_with(error: 'some_error')
    expect { room }.to raise_error(Eyeson::Room::ValidationFailed, 'some_error')
  end

  it 'should contain correct user fields in mapped_user' do
    api_response_with
    mapped = room.send(:mapped_user)
    expect(mapped[:id]).to eq(user.email)
    expect(mapped[:name]).to eq(user.name)
    expect(mapped[:avatar]).to eq(user.avatar)
  end
end
