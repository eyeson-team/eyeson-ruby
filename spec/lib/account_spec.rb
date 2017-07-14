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
    Eyeson.expects(:post).with('/internal/accounts',
                              user: user,
                              remote_ip: '1.2.3.4')
    expect(Eyeson::Account.find_or_initialize_by(user: user, remote_ip: '1.2.3.4')).kind_of? Eyeson::Account
  end

  it 'should return new_record? = false if confirmed' do
    Eyeson.expects(:post).with('/internal/accounts',
                              user: user,
                              remote_ip: '1.2.3.4').returns({ 'create_url' => nil })
    expect(Eyeson::Account.find_or_initialize_by(user: user, remote_ip: '1.2.3.4').new_record?).to eq(false)
  end

  it 'should return new_record? = true unless confirmed' do
    Eyeson.expects(:post).with('/internal/accounts',
                              user: user,
                              remote_ip: '1.2.3.4').returns({ 'create_url' => Faker::Internet.url })
    expect(Eyeson::Account.find_or_initialize_by(user: user, remote_ip: '1.2.3.4').new_record?).to eq(true)
  end

  it 'should return confirmation_url' do
    url = Faker::Internet.url
    Eyeson.expects(:post).with('/internal/accounts',
                              user: user,
                              remote_ip: '1.2.3.4').returns({ 'create_url' => url })
    expect(Eyeson::Account.find_or_initialize_by(user: user, remote_ip: '1.2.3.4').confirmation_url).to eq(url)
  end
end
