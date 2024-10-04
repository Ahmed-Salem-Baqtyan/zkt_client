# frozen_string_literal: true

require "forwardable"

require_relative "zkt_client/version"
require_relative "zkt_client/exceptions"
require_relative "zkt_client/http_client"
require_relative "zkt_client/models/area"
require_relative "zkt_client/access_token"
require_relative "zkt_client/configuration"
require_relative "zkt_client/models/device"
require_relative "zkt_client/models/employee"
require_relative "zkt_client/models/position"
require_relative "zkt_client/models/department"
require_relative "zkt_client/monky_patcher/nil"
require_relative "zkt_client/monky_patcher/hash"
require_relative "zkt_client/models/transaction"
require_relative "zkt_client/monky_patcher/true"
require_relative "zkt_client/monky_patcher/false"
require_relative "zkt_client/monky_patcher/array"
require_relative "zkt_client/monky_patcher/string"
require_relative "zkt_client/monky_patcher/integer"

# Main module for ZktClient
module ZktClient
  class << self
    extend Forwardable

    def_delegators(:configuration, *Configuration.instance_methods(false))

    # Configures the ZktClient
    #
    # @yield [Configuration] the configuration object
    # @return [void]
    def configure
      yield(configuration)
    end

    # Retrieves the configuration instance
    #
    # @return [Configuration] the configuration instance
    def configuration
      Configuration.instance
    end
  end
end
