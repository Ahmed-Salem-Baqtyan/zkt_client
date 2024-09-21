# frozen_string_literal: true

require 'byebug'
require 'forwardable'

Dir[
  "lib/zkt_client/*.rb",
  "lib/zkt_client/models/*.rb",
  "lib/zkt_client/monky_patcher/*.rb",
  "lib/zkt_client/params_validator/*.rb"
].each do |file|
  require_relative file.delete_prefix("lib/")
end

module ZktClient
  class << self
    extend Forwardable

    def_delegators(:configuration, *Configuration.instance_methods(false))

    def configure
      yield(configuration)
    end

    def configuration
      Configuration.instance
    end
  end
end
