# frozen_string_literal: true

module Zspay
  class Sale < Zspay::Resource
    class << self
      def create(sale)
        post('/vendas', sale)
      end

      def refund(sale_id)
        post("/vendas/#{sale_id}/estornar")
      end
    end
  end
end
