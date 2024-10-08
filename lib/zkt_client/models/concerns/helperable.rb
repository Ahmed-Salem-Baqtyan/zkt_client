# frozen_string_literal: true

require "ostruct"

module ZktClient
  # Helperable module provides utility methods for ZktClient
  module Helperable
    private

    # Validates the parameters for creating a resource
    #
    # @param params [Hash] the parameters to validate
    # @raise [ArgumentError] if required fields are missing or blank
    def validate_create_params!(params)
      self::REQUIRED_FEILDS.each do |field|
        validate!(params, field, required: true, blank: false)
      end

      params.except(*self::REQUIRED_FEILDS).each_key do |field|
        validate!(params, field.to_sym, blank: false)
      end
    end

    # Validates the parameters for updating a resource
    #
    # @param params [Hash] the parameters to validate
    # @raise [ArgumentError] if any fields are blank
    def validate_update_params!(params)
      params.each_key do |field|
        validate!(params, field.to_sym, blank: false)
      end
    end

    # Builds the response from the server
    #
    # @param response [Hash] the response from the server
    # @return [Array<OpenStruct>, Hash] the processed response
    def build_response(response)
      return response unless ZktClient.with_object_response?

      if response["data"].is_a?(Array)
        response["data"].map { |hash| init_object(hash) }
      else
        init_object(response)
      end
    end

    # Initializes an OpenStruct object from a hash
    #
    # @param hash [Hash] the hash to convert to an OpenStruct object
    # @return [OpenStruct] the initialized OpenStruct object
    def init_object(hash)
      OpenStruct.new(hash)
    end

    # Retrieves the access token for the API
    #
    # @raise [ZktClient::MissingConfigurationError] if the client is not configured
    # @return [String] the access token
    def access_token
      raise(ZktClient::MissingConfigurationError, "Configurations are missing!") unless ZktClient.configured?

      ZktClient.access_token || AccessToken.new.call
    end

    # Constructs a URL with the given resource ID
    #
    # @param id [Integer] the ID of the resource
    # @return [String] the constructed URL
    def url_with_id(id)
      "#{self::URLS[:base]}#{id}/"
    end

    # Generates the headers for the HTTP request
    #
    # @return [Hash] the headers for the request
    def headers
      {
        "Content-Type" => "application/json",
        "Authorization" => access_token
      }
    end
  end
end
