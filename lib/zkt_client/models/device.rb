# frozen_string_literal: true

require_relative "base"

module ZktClient
  class Device < Base
    URLS = {
      base: "/iclock/api/terminals/"
    }.freeze
    REQUIRED_FEILDS = %i[sn alias ip_address].freeze
  end
end
