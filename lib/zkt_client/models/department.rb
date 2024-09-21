# frozen_string_literal: true

require_relative "base"

module ZktClient
  class Department < Base
    URLS = { base: "/personnel/api/departments/" }.freeze
    REQUIRED_FEILDS = %i[emp_code department area].freeze
  end
end
