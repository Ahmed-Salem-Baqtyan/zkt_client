# frozen_string_literal: true

require_relative "base"

module ZktClient
  class Area < Base
    URLS = { base: "/personnel/api/areas/" }.freeze
    REQUIRED_FEILDS = %i[emp_code department area].freeze
  end
end
