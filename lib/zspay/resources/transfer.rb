# frozen_string_literal: true

module Zspay
  class Transfer < Zspay::Resource
    class << self
      def create(transfer, custom_token = nil)
        post('/transferencias', transfer, custom_token)
      end

      def schedule_transfer(transfer_id, custom_token = nil)
        get("/transferencias/agendadas/#{transfer_id}", custom_token)
      end

      def remove(transfer_id, custom_token = nil)
        delete("/transferencias/agendadas/#{transfer_id}", custom_token)
      end
    end
  end
end
