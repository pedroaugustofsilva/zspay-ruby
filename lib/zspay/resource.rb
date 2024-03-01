# frozen_string_literal: true

module Zspay
  # The Resource class provides methods to perform HTTP requests to the Zspay API.
  # This class is designed to be a base class from which other resource-specific classes can inherit.
  class Resource
    class << self
      # Performs a POST request to the specified API path.
      #
      # @param path [String] the API path to send the request to.
      # @param payload [Hash] the request payload, defaults to an empty hash.
      # @param custom_token [String, nil] an optional custom token to use for the request.
      # @param body [String] the format of the request body, defaults to 'json'.
      # @return [OpenStruct] the parsed response.
      def post(path, payload = {}, custom_token = nil, body: "json")
        req(:post, path, payload, custom_token, body: body)
      end

      # Performs a PATCH request to the specified API path.
      #
      # @param path [String] the API path to send the request to.
      # @param payload [Hash] the request payload.
      # @param custom_token [String, nil] an optional custom token to use for the request.
      # @return [OpenStruct] the parsed response.
      def patch(path, payload, custom_token = nil)
        req(:patch, path, payload, custom_token)
      end

      # Performs a GET request to the specified API path.
      #
      # @param path [String] the API path to send the request to.
      # @param custom_token [String, nil] an optional custom token to use for the request.
      # @return [OpenStruct] the parsed response.
      def get(path, custom_token = nil)
        req(:get, path, {}, custom_token)
      end

      # Performs a DELETE request to the specified API path.
      #
      # @param path [String] the API path to send the request to.
      # @param custom_token [String, nil] an optional custom token to use for the request.
      # @return [OpenStruct] the parsed response.
      def delete(path, custom_token = nil)
        req(:delete, path, {}, custom_token)
      end

      # Performs a PUT request to the specified API path.
      #
      # @param path [String] the API path to send the request to.
      # @param payload [Hash] the request payload, defaults to an empty hash.
      # @param custom_token [String, nil] an optional custom token to use for the request.
      # @return [OpenStruct] the parsed response.
      def put(path, payload = {}, custom_token = nil)
        req(:put, path, payload, custom_token)
      end

      private

      # A private method to perform an HTTP request using the specified method, path, and payload.
      #
      # @param method [Symbol] the HTTP method to use for the request.
      # @param path [String] the API path to send the request to.
      # @param payload [Hash] the request payload, defaults to an empty hash.
      # @param custom_token [String, nil] an optional custom token to use for the request.
      # @param body [String] the format of the request body, defaults to 'json'.
      # @return [OpenStruct] the parsed response.
      def req(method, path, payload = {}, custom_token = nil, body: "json")
        send("req_#{body}", method, path, payload, custom_token)
      end

      # A private method to send a request with JSON body format.
      #
      # @param method [Symbol] the HTTP method.
      # @param path [String] the path to send the request to.
      # @param payload [Hash] the request payload.
      # @param custom_token [String, nil] an optional custom token for the request.
      # @return [OpenStruct] the parsed response.
      def req_json(method, path, payload, custom_token)
        res = HTTP.headers(headers(custom_token)).send(method, "#{endpoint}#{path}", json: payload)

        parse_body(res)
      end

      # A private method to send a request with form body format.
      #
      # @param method [Symbol] the HTTP method.
      # @param path [String] the path to send the request to.
      # @param payload [Hash] the request payload.
      # @param custom_token [String, nil] an optional custom token for the request.
      # @return [OpenStruct] the parsed response.
      def req_form(method, path, payload, custom_token)
        payload = HTTP::FormData::Multipart.new(payload)
        res = HTTP.headers(headers(custom_token)).send(method, "#{endpoint}#{path}", form: payload)
        parse_body(res)
      end

      # Parses the response body and returns it as an OpenStruct.
      # If the request was successful, returns the JSON parsed body.
      # Otherwise, logs the error and returns an error message.
      #
      # @param response [HTTP::Response] the HTTP response to parse.
      # @return [OpenStruct] the parsed response.
      def parse_body(response)
        if success_request?(response)
          body = response.body.to_s
          json = parse_json(body)

          return json if json.is_a? OpenStruct

          OpenStruct.new({ success: false, error: body })
        else
          error_log = Logger.new(STDERR)
          error_log.error("Error while making Zspay request " \
                          "to: #{response.uri} " \
                          "body: #{response.body} " \
                          "status: #{response.code}")

          OpenStruct.new({ success: false, message: "An error occurred while making the request" })
        end
      end

      # Returns the base endpoint URL from the configuration.
      #
      # @return [String] the API endpoint URL.
      def endpoint
        Zspay::Configuration.endpoint
      end

      # Constructs the headers for the request.
      # If a custom token is provided, it is used; otherwise, the default token from configuration is used.
      #
      # @param custom_token [String, nil] an optional custom token for the request.
      # @return [Hash] the request headers.
      def headers(custom_token = nil)
        token = custom_token ? "Bearer #{custom_token}" : "Bearer #{Zspay::Configuration.token}"
        {
          Authorization: token
        }
      end

      # Determines whether the response was successful based on the status code.
      #
      # @param response [HTTP::Response] the response to check.
      # @return [Boolean] true if the response was successful, false otherwise.
      def success_request?(response)
        response.code.to_s =~ /2../ && response
      end

      # Parses a JSON string into an OpenStruct. If parsing fails, returns the original JSON string.
      #
      # @param json [String] the JSON string to parse.
      # @return [OpenStruct, String] the parsed JSON or the original string if parsing failed.
      def parse_json(json)
        JSON.parse(json, object_class: OpenStruct)
      rescue JSON::ParserError => _e
        json
      end
    end
  end
end
