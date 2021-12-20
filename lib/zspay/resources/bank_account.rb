# frozen_string_literal: true

module Zspay
  class BankAccount < Zspay::Resource
    class << self
      def index
        get('/estabelecimentos/contas_bancarias')
      end

      def create(account)
        post('/estabelecimentos/contas_bancarias', account)
      end

      def active(account_id)
        post("/estabelecimentos/contas_bancarias/#{account_id}/ativar")
      end

      def destroy(establishment_id, account_id)
        delete("/estabelecimentos/#{establishment_id}/contas_bancarias/#{account_id}/excluir")
      end
    end
  end
end
