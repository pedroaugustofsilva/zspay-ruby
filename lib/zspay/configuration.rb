# frozen_string_literal: true

module Zspay
  class Configuration
    class << self
      attr_accessor :token

      def endpoint
        'https://api.zsystems.com.br'
      end
    end
  end
end
