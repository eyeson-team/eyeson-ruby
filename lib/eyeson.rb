# Eyeson API
module Eyeson
  require 'rest_client'

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
require_relative 'eyeson/account'
require_relative 'eyeson/webhook'
require_relative 'eyeson/room'
require_relative 'eyeson/file_upload'
require_relative 'eyeson/layer'
require_relative 'eyeson/broadcast'
require_relative 'eyeson/message'
require_relative 'eyeson/recording'