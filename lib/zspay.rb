# frozen_string_literal: true

require 'http'
require 'byebug'
require 'logger'
require 'active_support/hash_with_indifferent_access'

require 'zspay/configuration'

require 'zspay/resource'
require 'zspay/resources'

module Zspay
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
