require 'spec_helper'

RSpec.describe Eyeson::Recording, type: :class do

  it 'should get a recording url' do
    response = {
      'links' => {
        'download' => Faker::Internet.url
      }
    }
    Eyeson.expects(:get).with('/recordings/123').returns(response)
    expect(Eyeson::Recording.find('123').url).to eq(response['links']['download'])
  end

  it 'should raise not found error' do
    Eyeson.expects(:get).returns({})
    expect { Eyeson::Recording.find('123') }.to raise_error(Eyeson::Recording::NotFound)
  end

  it 'should provide method to delete recording' do
    Eyeson.expects(:delete).with "/recordings/123"
    Eyeson::Recording.new(123, '').delete
  end
end
