# frozen_string_literal: true

require "faraday"

module ZktClient
  class HttpClient
    class << self
      #
      # make GET HTTP request
      # params uri [String]
      # params query_params [Hash]
      def get(url:, headers:, params: {})
        do_request(:get, url, params: params, headers: headers)
      end

      #
      # make POST HTTP request
      # params uri [String]
      # params body [Hash]
      def post(url:, params:, headers: {})
        do_request(:post, url, body: params, headers: headers)
      end

      #
      # make PUT HTTP request
      # params uri [String]
      # params body [Hash]
      def put(url:, params:, headers:)
        do_request(:put, url, body: params, headers: headers)
      end

      #
      # make PUT HTTP request
      # params uri [String]
      def delete(url:, headers:)
        do_request(:delete, url, headers: headers)
      end

      private

      #
      # make HTTP request
      # params method [Symbol]
      # params uri [String]
      # params query_params [Hash]
      # params body [Hash]
      def do_request(method, url, params: {}, body: {}, headers: {})
        uri = ZktClient.host + url

        request = connection.public_send(method, uri) do |req|
          req.headers = headers if headers.present?
          req.body = body if body.present?
          req.body = req.body.to_json if headers.present?
          req.params = params if params.present?
        end

        validate_status!(request) unless request.success?
        request.body
      end

      def connection
        Faraday.new do |conn|
          conn.request :url_encoded
          conn.response :json
          # conn.options[:timeout] = ZktClient.timeout
          conn.adapter Faraday.default_adapter
        end
      end

      def validate_status!(request)
        response = request.body
debugger
        case request.status
        when 404
          raise(ZktClient::RecordNotFound, response)
        when 400
          raise(ZktClient::BadRequestError, response)
        when 422
          raise(ZktClient::UnprocessableEntityError, response)
        when (500..599)
          raise(ZktClient::ServerError, response)
        else
          raise(ZktClient::RequestFailedError, response)
        end
      end
    end
  end
end
