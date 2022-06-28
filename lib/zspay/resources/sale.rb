# frozen_string_literal: true

module Zspay
  class Sale < Zspay::Resource
    class << self
      def create(sale, custom_token = nil)
        post('/vendas', sale, custom_token)
      end

      def show(sale_id, custom_token = nil)
        get("/vendas/#{sale_id}", custom_token)
      end

      def refund(sale_id, custom_token = nil)
        post("/vendas/#{sale_id}/estornar", payload = {}, custom_token)
      end
    end
  end
end
