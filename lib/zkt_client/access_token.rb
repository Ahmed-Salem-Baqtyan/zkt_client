# frozen_string_literal: true

# require_relative "zkt_client/http_client"

module ZktClient
  # AccessToken class handles the retrieval and validation of access tokens
  class AccessToken
    BASE_URL = '/api-token-auth/'.freeze

    # Calls the access token retrieval and validation process
    #
    # @return [String] the access token prefixed with "Token "
    def call
      validate!

      "Token #{access_token}"
    end

    private

    # Validates the presence of the access token
    #
    # @raise [ZktClient::UnauthorizedError] if the access token is nil
    def validate!
      raise(ZktClient::UnauthorizedError, 'Invalid credentials!') if access_token.nil?
    end

    # Retrieves the access token from the server
    #
    # @return [String] the access token
    def access_token
      return @access_token if instance_variable_defined?(:@access_token)

      @access_token = HttpClient.post(url: BASE_URL, params: params)['token']
    end

    # Constructs the parameters for the access token request
    #
    # @return [Hash] the parameters including username and password
    def params
      {
        username: ZktClient.username,
        password: ZktClient.password
      }
    end
  end
end
