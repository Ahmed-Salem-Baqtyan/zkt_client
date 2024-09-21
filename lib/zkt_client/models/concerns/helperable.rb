# frozen_string_literal: true

require 'ostruct'

module ZktClient
  # Helperable module provides utility methods for ZktClient
  module Helperable
    private

    # Validates the parameters for creating a resource
    #
    # @param params [Hash] the parameters to validate
    # @raise [ArgumentError] if required fields are missing or blank
    def validate_create_params!(params)
      REQUIRED_FEILDS.each do |field|
        validate!(params, field, required: true, blank: false)
      end

      params.except(*REQUIRED_FEILDS).each do |field|
        validate!(params, field.to_sym, blank: false)
      end
    end

    # Validates the parameters for updating a resource
    #
    # @param params [Hash] the parameters to validate
    # @raise [ArgumentError] if any fields are blank
    def validate_update_params!(params)
      params.each do |field|
        validate!(params, field.to_sym, blank: false)
      end
    end

    # Builds the response from the server
    #
    # @param response [Hash] the response from the server
    # @return [Array<OpenStruct>, Hash] the processed response
    def build_response(response)
      if ZktClient.with_object_response?
        (response['data'] || [response]).map { |hash| OpenStruct.new(hash) }
      else
        response
      end
    end

    # Retrieves the access token for the API
    #
    # @raise [ZktClient::MissingConfigurationError] if the client is not configured
    # @return [String] the access token
    def access_token
      unless ZktClient.configured?
        raise(ZktClient::MissingConfigurationError, 'Configurations are missing!')
      end

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
