require 'spec_helper'

RSpec.describe Eyeson::Snapshot, type: :class do

  it 'should get a Snapshot url' do
    response = {
      'links' => {
        'download' => Faker::Internet.url
      }
    }
    Eyeson.expects(:get).with('/snapshots/123').returns(response)
    expect(Eyeson::Snapshot.find('123').url).to eq(response['links']['download'])
  end

  it 'should raise not found error' do
    Eyeson.expects(:get).returns({})
    expect { Eyeson::Snapshot.find('123') }.to raise_error(Eyeson::Snapshot::NotFound)
  end
end
