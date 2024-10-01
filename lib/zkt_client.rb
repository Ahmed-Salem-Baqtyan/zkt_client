# frozen_string_literal: true

require "forwardable"

Dir[
  "lib/zkt_client/*.rb",
  "lib/zkt_client/models/*.rb",
  "lib/zkt_client/monky_patcher/*.rb",
  "lib/zkt_client/params_validator/*.rb"
].each do |file|
  require_relative file.delete_prefix("lib/")
end

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
