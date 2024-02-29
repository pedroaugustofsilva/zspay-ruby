# frozen_string_literal: true

module Zspay
  # The BankAccount class provides methods to manage bank accounts within the Zspay platform.
  # This class extends the Zspay::Resource class, utilizing its HTTP request methods.
  class BankAccount < Zspay::Resource
    class << self
      # Retrieves a list of all bank accounts associated with the current establishment.
      #
      # @return [OpenStruct] A list of bank accounts if the request is successful.
      def index
        get('/estabelecimentos/contas_bancarias')
      end

      # Creates a new bank account for the current establishment.
      #
      # @param account [Hash] The bank account details required for creation.
      # @return [OpenStruct] The created bank account details if the request is successful.
      def create(account)
        post('/estabelecimentos/contas_bancarias', account)
      end

      # Activates a specific bank account for the current establishment.
      #
      # @param account_id [String] The unique identifier of the bank account to be activated.
      # @return [OpenStruct] The status of the bank account after attempting activation.
      def active(account_id)
        post("/estabelecimentos/contas_bancarias/#{account_id}/ativar")
      end

      # Deletes a specific bank account from the establishment.
      #
      # @param establishment_id [String] The unique identifier of the establishment.
      # @param account_id [String] The unique identifier of the bank account to be deleted.
      # @return [OpenStruct] The status message indicating the result of the deletion request.
      def destroy(establishment_id, account_id)
        delete("/estabelecimentos/#{establishment_id}/contas_bancarias/#{account_id}/excluir")
      end
    end
  end
end
