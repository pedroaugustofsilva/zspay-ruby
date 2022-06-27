# frozen_string_literal: true

module Zspay
  class Sale < Zspay::Resource
    class << self
      def create(sale, custom_token = nil)
        post('/vendas', sale, custom_token)
      end

      def show(sale_id)
        get("/vendas/#{sale_id}")
      end

      def refund(sale_id)
        post("/vendas/#{sale_id}/estornar")
      end
    end
  end
end
