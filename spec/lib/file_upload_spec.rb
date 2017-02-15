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

  it 'should upload a downloadable file' do
    uri = URI.parse(Faker::Internet.url)
    uri.path = '/my_file.pdf'
    url = uri.to_s

    Tempfile.expects(:class_eval)
    tempfile = mock('Tempfile')
    tempfile.expects(:original_filename=).with('my_file.pdf')
    tempfile.expects(:unlink)

    upload.expects(:open).with(url).returns(tempfile)
    upload.expects(:upload!)
    upload.upload_from(url)
  end

  it 'should raise errors' do
    expects_api_response_with(error: 'some_error')
    expect { upload.send(:upload!) }.to raise_error(Eyeson::FileUpload::ValidationFailed, 'some_error')
  end
end
