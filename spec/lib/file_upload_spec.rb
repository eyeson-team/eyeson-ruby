require 'spec_helper'

RSpec.describe Eyeson::FileUpload, type: :class do
  let(:upload) do
    Eyeson::FileUpload.new('access_key')
  end

  it 'should upload a file' do
    Eyeson.expects(:post).with('/rooms/access_key/files',
                                file: nil).returns({})
    upload.send(:upload!)
  end

  it 'should download a tempfile from url' do
    uri = URI.parse(Faker::Internet.url)
    Net::HTTP.expects(:start).with(uri.host, uri.port)
    upload.send(:download_from, uri.to_s)
  end

  it 'should upload a downloadable file' do
    url = Faker::Internet.url
    upload.expects(:download_from).with(url)
    upload.expects(:upload!)
    upload.upload_from(url)
  end

  it 'should raise errors' do
    api_response_with(error: 'some_error')
    expect { upload.send(:upload!) }.to raise_error(Eyeson::FileUpload::ValidationFailed, 'some_error')
  end
end
