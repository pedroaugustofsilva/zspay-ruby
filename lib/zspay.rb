# frozen_string_literal: true

require "http"
require "logger"
require "active_support/hash_with_indifferent_access"

require "zspay/version"

require "zspay/configuration"

require "zspay/resource"
require "zspay/resources"

# The Zspay module is the main namespace for the Zspay gem.
# It provides methods to configure and access the gem's settings.
#
# Examples:
#   Zspay.configure do |config|
#     config.token = 'your_api_token'
#   end
module Zspay
  class << self
    # Returns the configuration object for Zspay. If the configuration
    # has not yet been initialized, it will create a new instance of
    # Configuration.
    #
    # @return [Zspay::Configuration] the current Zspay configuration
    def configuration
      @configuration ||= Configuration.new
    end

    # Yields the current Zspay configuration to a block.
    # This method is typically used to set up the gem's settings.
    #
    # @yieldparam config [Zspay::Configuration] the current Zspay configuration
    # @example
    #   Zspay.configure do |config|
    #     config.token = 'your_api_token'
    #   end
    def configure
      yield(configuration)
    end
  end
end
