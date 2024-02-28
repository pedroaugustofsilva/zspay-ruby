# frozen_string_literal: true

module Zspay
  # The Configuration class is used to manage configuration settings for the Zspay library.
  # It provides class-level accessors and methods to set and retrieve the configuration settings.
  class Configuration
    class << self
      # @!attribute [rw] token
      #   @return [String] the API token used for authenticating requests to the Zspay service.
      attr_accessor :token

      # Returns the default API endpoint for the Zspay service.
      #
      # @return [String] the base URL of the Zspay API endpoint.
      def endpoint
        'https://api.zsystems.com.br'
      end
    end
  end
end
