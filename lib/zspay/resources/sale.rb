# frozen_string_literal: true

module Zspay
  class Sale < Zspay::Resource
    class << self
      def create(sale)
        post('/vendas', sale)
      end
    end
  end
end
