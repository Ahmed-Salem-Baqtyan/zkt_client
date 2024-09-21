# frozen_string_literal: true

require_relative "base"

module ZktClient
  # Area class handles operations related to areas in the ZktClient
  class Area < Base
    # URL endpoints for the Area resource
    URLS = { base: "/personnel/api/areas/" }.freeze

    # Required fields for creating or updating an Area resource
    REQUIRED_FEILDS = %i[emp_code department area].freeze
  end
end
