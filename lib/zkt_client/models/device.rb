# frozen_string_literal: true

require_relative "base"

module ZktClient
  # Department class handles operations related to devices in the ZktClient
  class Device < Base
    # URL endpoints for the device resource
    URLS = { base: "/iclock/api/terminals/" }.freeze

    # Required fields for creating or updating a device resource
    REQUIRED_FEILDS = %i[sn alias ip_address].freeze
  end
end
