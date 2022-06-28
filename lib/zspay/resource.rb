# frozen_string_literal: true

module Zspay
  class Resource
    class << self
      def post(path, payload = {}, custom_token = nil, body: 'json')
        req(:post, path, payload, custom_token, body: body)
      end

      def patch(path, payload, custom_token = nil)
        req(:patch, path, payload, custom_token)
      end

      def get(path, custom_token = nil)
        req(:get, path, {}, custom_token)
      end

      def delete(path, custom_token = nil)
        req(:delete, path, {}, custom_token)
      end

      def put(path, payload = {}, custom_token = nil)
        req(:put, path, payload, custom_token)
      end

      private

      def req(method, path, payload = {}, custom_token = nil, body: 'json')
        send("req_#{body}", method, path, payload, custom_token)
      end

      def req_json(method, path, payload, custom_token)
        res = HTTP.headers(headers(custom_token)).send(method, "#{endpoint}#{path}", json: payload)

        parse_body(res)
      end

      def req_form(method, path, payload, custom_token)
        payload = HTTP::FormData::Multipart.new(payload)
        res = HTTP.headers(headers(custom_token)).send(method, "#{endpoint}#{path}", form: payload)
        parse_body(res)
      end

      def parse_body(response)
        if success_request?(response)
          body = response.body.to_s
          json = parse_json(body)

          return json if json.is_a? OpenStruct

          OpenStruct.new({ success: false, error: body })
        else
          error_log = Logger.new(STDERR)
          error_log.error("Error while making Zspay request" \
                            " to: #{response.uri}" \
                            " body: #{response.body}" \
                            " status: #{response.code}")

          OpenStruct.new({ success: false, message: 'An error occurred while making the request' })
        end
      end

      def endpoint
        Zspay::Configuration.endpoint
      end

      def headers(custom_token = nil)
        token = custom_token ? "Bearer #{custom_token}" : "Bearer #{Zspay::Configuration.token}"
        {
          'Authorization': token
        }
      end

      def success_request?(response)
        response.code.to_s =~ /2../ && response
      end

      def parse_json(json)
        JSON.parse(json, object_class: OpenStruct)
      rescue JSON::ParserError => e
        json
      end
    end
  end
end
