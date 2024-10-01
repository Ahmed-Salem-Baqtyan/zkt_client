# frozen_string_literal: true

require_relative "../models/concerns/helperable"
require_relative "../models/concerns/validatable"

module ZktClient
  # Base class for ZktClient module
  class Base
    extend Helperable
    extend Validatable

    class << self
      # Shows the details of a specific resource by ID
      #
      # @param id [Integer] the ID of the resource
      # @return [Hash] the response from the server
      def show(id)
        response = HttpClient.get(url: url_with_id(id), headers:)

        build_response(response)
      end

      # Lists all resources with optional parameters
      #
      # @param params [Hash] optional parameters for filtering the list
      # @return [Array<Hash>] the list of resources
      def list(**params)
        response = HttpClient.get(url: self::URLS[:base], headers:, params:)

        build_response(response)
      end

      # Creates a new resource with the given parameters
      #
      # @param params [Hash] the parameters for creating the resource
      # @return [Hash] the response from the server
      def create(params)
        validate_create_params!(params)
        response = HttpClient.post(url: self::URLS[:base], headers:, params:)

        build_response(response)
      end

      # Updates an existing resource by ID with the given parameters
      #
      # @param id [Integer] the ID of the resource
      # @param params [Hash] the parameters for updating the resource
      # @return [Hash] the response from the server
      def update(id, params)
        validate_update_params!(params)
        response = HttpClient.put(url: url_with_id(id), headers:, params:)

        build_response(response)
      end

      # Deletes a resource by ID
      #
      # @param id [Integer] the ID of the resource
      # @return [Boolean] true if the resource was successfully deleted
      def delete(id)
        HttpClient.delete(url: url_with_id(id), headers:)

        true
      end
    end
  end
end
