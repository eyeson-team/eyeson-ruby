require 'spec_helper'

RSpec.describe Eyeson::Account, type: :class do
  it 'should find_by email' do
    RestClient::Request.expects(:new)
    Eyeson.expects(:response_for).returns(nil)
    expect(Eyeson::Account.find_by(email: Faker::Internet.email)).kind_of? Eyeson::Account
  end

  it 'should return present? = true if confirmed' do
    RestClient::Request.expects(:new)
    Eyeson.expects(:response_for).returns(nil)
    expect(Eyeson::Account.find_by(email: Faker::Internet.email).present?).to eq(true)
  end

  it 'should return present? = false unless confirmed' do
    RestClient::Request.expects(:new)
    Eyeson.expects(:response_for).returns('create_url' => Faker::Internet.url)
    expect(Eyeson::Account.find_by(email: Faker::Internet.email).present?).to eq(false)
  end

  it 'should return confirmation_url' do
    url = Faker::Internet.url
    RestClient::Request.expects(:new)
    Eyeson.expects(:response_for).returns('create_url' => url)
    expect(Eyeson::Account.find_by(email: Faker::Internet.email).confirmation_url).to eq(url)
  end
end
