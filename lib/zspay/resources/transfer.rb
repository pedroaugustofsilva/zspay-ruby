# frozen_string_literal: true

module Zspay
  class Transfer < Zspay::Resource
    class << self
      def create(transfer, custom_token = nil)
        post('/transferencias', transfer, custom_token)
      end

      def schedule_transfer(transfer_id)
        get("/transferencias/agendadas/#{transfer_id}")
      end

      def remove(transfer_id)
        delete("/transferencias/agendadas/#{transfer_id}")
      end
    end
  end
end
