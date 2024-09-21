# frozen_string_literal: true

require_relative "base"

module ZktClient
  # Position class handles operations related to positions in the ZktClient
  class Position < Base
    # URL endpoints for the Position resource
    URLS = { base: "/personnel/api/positions/" }.freeze

    # Required fields for creating or updating a Position resource
    REQUIRED_FEILDS = %i[position_code position_name].freeze
  end
end
