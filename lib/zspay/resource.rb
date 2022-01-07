# frozen_string_literal: true

module Zspay
  class Resource
    class << self
      def post(path, payload = {}, body: 'json')
        req(:post, path, payload, body: body)
      end

      def patch(path, payload)
        req(:patch, path, payload)
      end

      def get(path)
        req(:get, path)
      end

      def delete(path)
        req(:delete, path)
      end

      def put(path, payload = {})
        req(:put, path, payload)
      end

      private

      def req(method, path, payload = {}, body: 'json')
        send("req_#{body}", method, path, payload)
      end

      def req_json(method, path, payload)
        res = HTTP.headers(headers).send(method, "#{endpoint}#{path}", json: payload)

        parse_body(res)
      end

      def req_form(method, path, payload)
        payload = HTTP::FormData::Multipart.new(payload)
        res = HTTP.headers(headers).send(method, "#{endpoint}#{path}", form: payload)
        parse_body(res)
      end

      def parse_body(response)
        if success_request?(response)
          body = response.body.to_s
          json = parse_json(body)

          json.message = parse_json(json.message.gsub(/^\d+ - /, '')) if json.message

          return json if json

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

      def headers
        {
          'Authorization': "Bearer #{Zspay::Configuration.token}"
        }
      end

      def success_request?(response)
        response.code.to_s =~ /2../ && response
      end

      def parse_json(json)
        JSON.parse(json, object_class: OpenStruct)
      rescue JSON::ParserError => e
        nil
      end
    end
  end
end
