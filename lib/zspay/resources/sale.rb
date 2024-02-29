# frozen_string_literal: true

module Zspay
  # The Sale class manages sale-related actions within the Zspay platform.
  # It provides methods to create a sale, retrieve sale details, and refund a sale,
  # extending the functionality from Zspay::Resource.
  class Sale < Zspay::Resource
    class << self
      # Creates a new sale on the Zspay platform.
      #
      # @param sale [Hash] A hash containing the sale information.
      # @param custom_token [String, nil] An optional custom token to use for the request.
      # @return [OpenStruct] A structure containing the newly created sale's details if the request is successful.
      def create(sale, custom_token = nil)
        post('/vendas', sale, custom_token)
      end

      # Retrieves details of a specific sale.
      #
      # @param sale_id [String] The unique identifier of the sale to retrieve.
      # @param custom_token [String, nil] An optional custom token to use for the request.
      # @return [OpenStruct] A structure containing the sale's details if the request is successful.
      def show(sale_id, custom_token = nil)
        get("/vendas/#{sale_id}", custom_token)
      end

      # Processes a refund for a specific sale.
      #
      # This method sends a request to refund a previously made sale. The sale is identified by its unique ID.
      #
      # @param sale_id [String] The unique identifier of the sale to refund.
      # @param custom_token [String, nil] An optional custom token to use for the request.
      # @return [OpenStruct] A structure indicating the result of the refund operation if the request is successful.
      def refund(sale_id, custom_token = nil)
        post("/vendas/#{sale_id}/estornar", {}, custom_token)
      end
    end
  end
end
