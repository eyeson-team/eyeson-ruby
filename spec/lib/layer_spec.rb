require 'spec_helper'

RSpec.describe Eyeson::Layer, type: :class do

  let(:layer) do
    Eyeson::Layer.new('access_key')
  end

  let(:image) do
    Tempfile.new('image')
  end

  it 'should set layer by image and index' do
    Eyeson.expects(:post).with('/rooms/access_key/layers',
                                image: image,
                                'z-index' => -1,
                                layout: 'fixed').returns({})
    layer.create(image: image, index: -1, layout: 'fixed')
  end

  it 'should clear layer by index' do
    Eyeson.expects(:delete).with('/rooms/access_key/layers/-1')
    layer.destroy(index: -1)
  end

  it 'should raise errors' do
    expects_api_response_with(error: 'some_error')
    expect { layer.create }.to raise_error(Eyeson::Layer::ValidationFailed, 'some_error')
  end
end
