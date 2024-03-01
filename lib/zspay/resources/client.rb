# frozen_string_literal: true

module Zspay
  # The Client class is responsible for handling client-related actions within the Zspay platform.
  # It allows for creating clients and their associated cards by extending the Zspay::Resource class.
  class Client < Zspay::Resource
    class << self
      # Creates a new client on the Zspay platform.
      #
      # This method sends a POST request to the Zspay API to create a new client record.
      # The client's information should be provided in the form of a hash.
      #
      # @param client [Hash] A hash containing the client's information, such as name, email, etc.
      # @return [OpenStruct] A structure containing the newly created client's details if successful.
      def create(client)
        post("/clientes", client)
      end

      # Adds a new card for an existing client on the Zspay platform.
      #
      # This method sends a POST request to add a new card to the specified client's account.
      # The card information, including number, expiry date, and CVV, should be provided in the form of a hash.
      #
      # @param client_id [String] The unique identifier of the client to whom the card will be added.
      # @param card [Hash] A hash containing the card's information, such as number, expiry date, and CVV.
      # @return [OpenStruct] A structure containing the newly added card's details if successful.
      def create_card(client_id, card)
        post("/clientes/#{client_id}/cartoes", card)
      end
    end
  end
end
