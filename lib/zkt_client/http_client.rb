# frozen_string_literal: true

require "faraday"

module ZktClient
  # HttpClient class handles HTTP requests for ZktClient
  class HttpClient
    class << self
      # Makes a GET HTTP request
      #
      # @param url [String] the URL to send the request to
      # @param headers [Hash] the headers to include in the request
      # @param params [Hash] the query parameters to include in the request
      # @return [Hash] the response body
      def get(url:, headers:, params: {})
        do_request(:get, url, params: params, headers: headers)
      end

      # Makes a POST HTTP request
      #
      # @param url [String] the URL to send the request to
      # @param params [Hash] the body of the request
      # @param headers [Hash] the headers to include in the request
      # @return [Hash] the response body
      def post(url:, params:, headers: {})
        do_request(:post, url, body: params, headers: headers)
      end

      # Makes a PUT HTTP request
      #
      # @param url [String] the URL to send the request to
      # @param params [Hash] the body of the request
      # @param headers [Hash] the headers to include in the request
      # @return [Hash] the response body
      def put(url:, params:, headers:)
        do_request(:put, url, body: params, headers: headers)
      end

      # Makes a DELETE HTTP request
      #
      # @param url [String] the URL to send the request to
      # @param headers [Hash] the headers to include in the request
      # @return [Hash] the response body
      def delete(url:, headers:)
        do_request(:delete, url, headers: headers)
      end

      private

      # Makes an HTTP request
      #
      # @param method [Symbol] the HTTP method to use (:get, :post, :put, :delete)
      # @param url [String] the URL to send the request to
      # @param params [Hash] the query parameters to include in the request
      # @param body [Hash] the body of the request
      # @param headers [Hash] the headers to include in the request
      # @return [Hash] the response body
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

      # Establishes a Faraday connection
      #
      # @return [Faraday::Connection] the Faraday connection
      def connection
        Faraday.new do |conn|
          conn.request :url_encoded
          conn.response :json
          # conn.options[:timeout] = ZktClient.timeout
          conn.adapter Faraday.default_adapter
        end
      end

      # Validates the status of the HTTP response
      #
      # @param request [Faraday::Response] the HTTP response
      # @raise [ZktClient::RecordNotFound] if the response status is 404
      # @raise [ZktClient::BadRequestError] if the response status is 400
      # @raise [ZktClient::UnprocessableEntityError] if the response status is 422
      # @raise [ZktClient::ServerError] if the response status is 500-599
      # @raise [ZktClient::RequestFailedError] for other response statuses
      def validate_status!(request)
        response = request.body

        case request.status
        when 404
          raise(ZktClient::RecordNotFound, response)
        when 400
          raise(ZktClient::BadRequestError, response)
        when 422
          raise(ZktClient::UnprocessableEntityError, response)
        when 500..599
          raise(ZktClient::ServerError, response)
        else
          raise(ZktClient::RequestFailedError, response)
        end
      end
    end
  end
end
