# frozen_string_literal: true

# require_relative "zkt_client/http_client"

module ZktClient
  # AccessToken class handles the retrieval of access token
  class AccessToken
    BASE_URL = "/api-token-auth/"

    # Calls the access token retrieval
    #
    # @return [String] the access token prefixed with "Token "
    def call
      "Token #{access_token}"
    end

    private

    # Retrieves the access token from the server
    #
    # @return [String] the access token
    def access_token
      HttpClient.post(url: BASE_URL, params:)["token"]
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
