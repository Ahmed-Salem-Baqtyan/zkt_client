# frozen_string_literal: true

require "zkt_client"

module ZktClient
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "This generator creates an initializer file at config/initializers, " \
           "with the default configuration options for ZktClient."
      source_root File.expand_path("templates", __dir__)

      # copy rake tasks
      def copy_tasks
        template "configure_template.rake", "config/initializers/zkt_client.rb"
      end
    end
  end
end
