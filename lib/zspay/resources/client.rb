# frozen_string_literal: true

module Zspay
  class Client < Zspay::Resource
    class << self
      def create(client)
        post('/clientes', client)
      end

      def create_card(client_id, card)
        post("/clientes/#{client_id}/cartoes", card)
      end
    end
  end
end
