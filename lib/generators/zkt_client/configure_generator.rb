require 'zkt_client'

module ZktClient
  module Generators
    class ConfigureGenerator < Rails::Generators::Base
      desc "This generator creates an initializer file at config/initializers, " +
         "with the default configuration options for ZktClient."
      source_root File.expand_path('templates', __dir__)

      # copy rake tasks
      def copy_tasks
        template 'auto_annotate_models.rake', 'lib/tasks/auto_annotate_models.rake'
      end
    end
  end
end
