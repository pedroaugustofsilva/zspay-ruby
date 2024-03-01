# frozen_string_literal: true

module Zspay
  # The Transfer class manages transfer-related actions within the Zspay platform.
  # It provides methods to create, schedule, and remove transfers, extending from Zspay::Resource.
  class Transfer < Zspay::Resource
    class << self
      # Creates a new transfer on the Zspay platform.
      #
      # This method sends a POST request to create a new transfer with the provided details.
      #
      # @param transfer [Hash] A hash containing the transfer details.
      # @param custom_token [String, nil] An optional custom token to use for the request.
      # @return [OpenStruct] A structure containing the newly created transfer's details if the request is successful.
      def create(transfer, custom_token = nil)
        post("/transferencias", transfer, custom_token)
      end

      # Retrieves the details of a scheduled transfer.
      #
      # This method sends a GET request to obtain details about a transfer that has been scheduled.
      #
      # @param transfer_id [String] The unique identifier of the scheduled transfer.
      # @param custom_token [String, nil] An optional custom token to use for the request.
      # @return [OpenStruct] A structure containing the scheduled transfer's details if the request is successful.
      def schedule_transfer(transfer_id, custom_token = nil)
        get("/transferencias/agendadas/#{transfer_id}", custom_token)
      end

      # Cancels a scheduled transfer.
      #
      # This method sends a DELETE request to remove a previously scheduled transfer from the system.
      #
      # @param transfer_id [String] The unique identifier of the transfer to be removed.
      # @param custom_token [String, nil] An optional custom token to use for the request.
      # @return [OpenStruct] A structure indicating the result of the cancellation if the request is successful.
      def remove(transfer_id, custom_token = nil)
        delete("/transferencias/agendadas/#{transfer_id}", custom_token)
      end
    end
  end
end
