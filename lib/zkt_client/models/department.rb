# frozen_string_literal: true

require_relative "base"

module ZktClient
  # Department class handles operations related to departments in the ZktClient
  class Department < Base
    # URL endpoints for the Department resource
    URLS = { base: "/personnel/api/departments/" }.freeze

    # Required fields for creating or updating a Department resource
    REQUIRED_FEILDS = %i[dept_code dept_name].freeze
  end
end
