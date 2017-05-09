require 'spec_helper'

RSpec.describe Eyeson::Layer, type: :class do

  let(:layer) do
    Eyeson::Layer.new('access_key')
  end

  let(:image) do
    Tempfile.new('image')
  end

  it 'should set layer by file and index' do
    Eyeson.expects(:post).with('/rooms/access_key/layers',
                                file: image,
                                url: nil,
                                'z-index' => -1,
                                layout: nil).returns({})
    layer.create(file: image, index: -1)
  end

  it 'should set layer by url' do
    url = Faker::Internet.url
    Eyeson.expects(:post).with('/rooms/access_key/layers',
                                file: nil,
                                url: url,
                                'z-index' => 1,
                                layout: nil).returns({})
    layer.create(url: url)
  end

  it 'should set layer by url and layer' do
    url = Faker::Internet.url
    Eyeson.expects(:post).with('/rooms/access_key/layers',
                                file: nil,
                                url: url,
                                'z-index' => 1,
                                layout: 'fixed').returns({})
    layer.create(url: url, layout: 'fixed')
  end

  it 'should clear layer by index' do
    Eyeson.expects(:delete).with('/rooms/access_key/layers/-1', layout: nil)
    layer.destroy(index: -1)
  end

  it 'should clear layer by index and layer' do
    Eyeson.expects(:delete).with('/rooms/access_key/layers/-1', layout: 'auto')
    layer.destroy(index: -1, layout: 'auto')
  end

  it 'should raise errors' do
    expects_api_response_with(error: 'some_error')
    expect { layer.create }.to raise_error(Eyeson::Layer::ValidationFailed, 'some_error')
  end
end
