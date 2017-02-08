# Eyeson API
module Eyeson
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end

require_relative 'eyeson/config'
require_relative 'eyeson/requests'
require_relative 'eyeson/internal'
require_relative 'eyeson/api_key'
require_relative 'eyeson/room'
require_relative 'eyeson/file_upload'
