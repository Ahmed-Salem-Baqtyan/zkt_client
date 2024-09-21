# frozen_string_literal: true

require_relative "base"

module ZktClient
  class Employee < Base
    URLS = {
      base: '/personnel/api/employees/'
    }.freeze
    REQUIRED_FEILDS = %i[emp_code department area].freeze

    class << self
      private

      def validate_create_params!(params)
        super(params)
        validate!(params, :app_status, in: [1, 0, 'Enable', 'Disable'])
      end

      def validate_update_params!(params)
        super(params)
        validate!(params, :gender, in: %w[F M])
        validate!(params, :app_status, in: [1, 0, 'Enable', 'Disable'])
      end
    end
  end
end
