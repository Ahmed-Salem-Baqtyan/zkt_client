# frozen_string_literal: true

require 'singleton'

module ZktClient
  class Configuration
    include Singleton

    attr_writer :host, :username, :password, :access_token, :is_object_response_enabled

    def host
      @host || ENV['ZKT_CLIENT_HOST']
    end
    
    def username
      @username || ENV['ZKT_CLIENT_USERNAME']
    end

    def password
      @password || ENV['ZKT_CLIENT_PASSWORD']
    end

    def access_token
      @access_token || ENV['ZKT_CLIENT_ACCESS_TOKEN']
    end

    def with_object_response?
      @is_object_response_enabled || ENV['ZKT_OBJECT_RESPONSE_ENABLED'] || false
    end

    def configured?
      host.present? &&
      (access_token.present? || (username.present? && password.present?))
    end
  end
end
