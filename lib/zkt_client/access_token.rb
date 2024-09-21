# frozen_string_literal: true

# require_relative "zkt_client/http_client"

module ZktClient
  class AccessToken
    BASE_URL = '/api-token-auth/'

    def call
      validate!

      "Token #{access_token}"
    end

    private

    def validate!
      raise(ZktClient::UnauthorizedError, 'Invalid credentials!') if access_token.nil?
    end
    
    def access_token
      return @access_token if instance_variable_defined?(:@access_token)

      @access_token = HttpClient.post(url: BASE_URL, params: params)['token']
    end

    def params
      {
        username: ZktClient.username,
        password: ZktClient.password
      }
    end
  end
end
