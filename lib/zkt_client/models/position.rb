# frozen_string_literal: true

require_relative "base"

module ZktClient
  class Position < Base
    URLS = { base: "/personnel/api/positions/" }.freeze
    REQUIRED_FEILDS = %i[position_code position_name].freeze
  end
end
