# frozen_string_literal: true

module Zspay
  class Establishments < Zspay::Resource
    class << self
      def index
        get('/estabelecimentos/filhos')
      end

      def create(establishment)
        post('/estabelecimentos', establishment, body: 'form')
      end

      def active(establishment_id)
        post("/estabelecimentos/#{establishment_id}/habilitar")
      end

      def disable(establishment_id)
        delete("/estabelecimentos/#{establishment_id}")
      end

      def token(establishment_id)
        get("/estabelecimentos/#{establishment_id}/token")
      end

      def balance(establishment_id)
        get("/estabelecimentos/#{establishment_id}/saldo")
      end

      def search_by_document(document)
        get("/estabelecimentos/por_documento/#{document}")
      end
    end
  end
end
