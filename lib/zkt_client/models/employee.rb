# frozen_string_literal: true

require_relative "base"

module ZktClient
  # Employee class handles operations related to employees in the ZktClient
  class Employee < Base
    # URL endpoints for the Employee resource
    URLS = {
      base: "/personnel/api/employees/"
    }.freeze

    # Required fields for creating or updating an Employee resource
    REQUIRED_FEILDS = %i[emp_code department area].freeze

    class << self
      private

      # Validates the parameters for creating an Employee resource
      #
      # @param params [Hash] the parameters to validate
      # @raise [ArgumentError] if required fields are missing or invalid
      def validate_create_params!(params)
        super(params)
        validate!(params, :app_status, in: [1, 0, "Enable", "Disable"])
        validate!(params, :area, type: Array)
      end

      # Validates the parameters for updating an Employee resource
      #
      # @param params [Hash] the parameters to validate
      # @raise [ArgumentError] if required fields are missing or invalid
      def validate_update_params!(params)
        super(params)
        validate!(params, :gender, in: %w[F M])
        validate!(params, :app_status, in: [1, 0, "Enable", "Disable"])
      end
    end
  end
end
