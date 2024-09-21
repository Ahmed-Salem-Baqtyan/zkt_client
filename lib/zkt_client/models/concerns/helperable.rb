# frozen_string_literal: true

require 'ostruct'

module ZktClient
  module Helperable
    private

    def validate_create_params!(params)
      REQUIRED_FEILDS.each do |field|
        validate!(params, field, required: true, blank: false)
      end

      params.except(*REQUIRED_FEILDS).each do |field|
        validate!(params, field.to_sym, blank: false)
      end
    end

    def validate_update_params!(params)
      params.each do |field|
        validate!(params, field.to_sym, blank: false)
      end
    end

    def build_response(response)
      if ZktClient.with_object_response?
        (response['data'] || [response]).map { |hash| OpenStruct.new(hash) }
      else
        response
      end
    end
    
    def access_token
      unless ZktClient.configured?
        raise(ZktClient::MissingConfigurationError, 'Configurations are missing!')
      end

      ZktClient.access_token || AccessToken.new.call
    end

    def url_with_id(id)
      "#{self::URLS[:base]}#{id}/"
    end

    def headers
      {
        "Content-Type" => "application/json",
        "Authorization" => access_token
      }
    end
  end
end

