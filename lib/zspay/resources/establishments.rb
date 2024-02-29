# frozen_string_literal: true

module Zspay
  # The Establishments class manages establishment-related actions within the Zspay platform.
  # It allows for listing, creating, enabling, disabling establishments, and more, extending the functionality from Zspay::Resource.
  class Establishments < Zspay::Resource
    class << self
      # Retrieves a list of child establishments associated with the current establishment.
      #
      # @return [OpenStruct] A structure containing the list of child establishments if the request is successful.
      def index
        get('/estabelecimentos/filhos')
      end

      # Creates a new establishment on the Zspay platform.
      #
      # @param establishment [Hash] A hash containing the establishment's information.
      # @return [OpenStruct] A structure containing the newly created establishment's details if the request is successful.
      def create(establishment)
        post('/estabelecimentos', establishment, body: 'form')
      end

      # Activates an existing establishment on the Zspay platform.
      #
      # @param establishment_id [String] The unique identifier of the establishment to be activated.
      # @return [OpenStruct] A structure indicating the activation status of the establishment if the request is successful.
      def active(establishment_id)
        post("/estabelecimentos/#{establishment_id}/habilitar")
      end

      # Disables an existing establishment on the Zspay platform.
      #
      # @param establishment_id [String] The unique identifier of the establishment to be disabled.
      # @return [OpenStruct] A structure indicating the disabled status of the establishment if the request is successful.
      def disable(establishment_id)
        delete("/estabelecimentos/#{establishment_id}")
      end

      # Retrieves the token associated with a specific establishment.
      #
      # This token is typically used for authentication in subsequent API requests.
      #
      # @param establishment_id [String] The unique identifier of the establishment for which to retrieve the token.
      # @return [OpenStruct] A structure containing the establishment's token if the request is successful.
      def token(establishment_id)
        get("/estabelecimentos/#{establishment_id}/token")
      end

      # Retrieves the balance of a specific establishment.
      #
      # @param establishment_id [String] The unique identifier of the establishment for which to retrieve the balance.
      # @return [OpenStruct] A structure containing the establishment's balance details if the request is successful.
      def balance(establishment_id)
        get("/estabelecimentos/#{establishment_id}/saldo")
      end

      # Searches for an establishment based on its document number.
      #
      # @param document [String] The document number of the establishment to search for.
      # @return [OpenStruct] A structure containing the establishment's details if found, otherwise an error message.
      def search_by_document(document)
        get("/estabelecimentos/por_documento/#{document}")
      end
    end
  end
end
