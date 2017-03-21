require 'spec_helper'

RSpec.describe Eyeson::Account, type: :class do
  let(:user) do
    {
      email:  Faker::Internet.email,
      name:   Faker::Name.name,
      avatar: Faker::Internet.url
    }
  end

  it 'should find_by email' do
    RestClient::Request.expects(:new)
    Eyeson.expects(:response_for).returns(nil)
    expect(Eyeson::Account.find_or_initialize_by(user: user)).kind_of? Eyeson::Account
  end

  it 'should authenticate in accounts api' do
    RestClient::Request.expects(:new).with(
      method: :get,
      url: 'https://account.eyeson.team/api/confirmation',
      headers: { authorization: Eyeson.configuration.account_api_key,
                 accept: 'application/json',
                 params: { user: user } }
    )
    Eyeson.expects(:response_for)
    Eyeson::Account.confirmed?(user: user)
  end

  it 'should return new_record? = false if confirmed' do
    RestClient::Request.expects(:new)
    Eyeson.expects(:response_for).returns(nil)
    expect(Eyeson::Account.find_or_initialize_by(user: user).new_record?).to eq(false)
  end

  it 'should return new_record? = true unless confirmed' do
    RestClient::Request.expects(:new)
    Eyeson.expects(:response_for).returns('create_url' => Faker::Internet.url)
    expect(Eyeson::Account.find_or_initialize_by(user: user).new_record?).to eq(true)
  end

  it 'should return confirmation_url' do
    url = Faker::Internet.url
    RestClient::Request.expects(:new)
    Eyeson.expects(:response_for).returns('create_url' => url)
    expect(Eyeson::Account.find_or_initialize_by(user: user).confirmation_url).to eq(url)
  end

  it 'should contain correct user fields in mapped_user' do
    mapped = Eyeson::Account.mapped_user(user)
    expect(mapped[:id]).to eq(user[:email])
    expect(mapped[:email]).to eq(user[:email])
    expect(mapped[:name]).to eq(user[:name])
    expect(mapped[:avatar]).to eq(user[:avatar])
  end
end
