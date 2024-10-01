# frozen_string_literal: true

require "singleton"

module ZktClient
  # Configuration class handles the configuration settings for ZktClient
  class Configuration
    include Singleton

    attr_writer :host, :username, :password, :access_token, :is_object_response_enabled

    # Retrieves the host configuration
    #
    # @return [String, nil] the host or nil if not set
    def host
      @host || ENV["ZKT_CLIENT_HOST"]
    end

    # Retrieves the username configuration
    #
    # @return [String, nil] the username or nil if not set
    def username
      @username || ENV["ZKT_CLIENT_USERNAME"]
    end

    # Retrieves the password configuration
    #
    # @return [String, nil] the password or nil if not set
    def password
      @password || ENV["ZKT_CLIENT_PASSWORD"]
    end

    # Retrieves the access token configuration
    #
    # @return [String, nil] the access token or nil if not set
    def access_token
      @access_token || ENV["ZKT_CLIENT_ACCESS_TOKEN"]
    end

    # Checks if object response is enabled
    #
    # @return [Boolean] true if object response is enabled, false otherwise
    def with_object_response?
      @is_object_response_enabled || ENV["ZKT_OBJECT_RESPONSE_ENABLED"] || false
    end

    # Checks if the client is configured
    #
    # @return [Boolean] true if the client is configured, false otherwise
    def configured?
      host.present? &&
        (access_token.present? || (username.present? && password.present?))
    end
  end
end
