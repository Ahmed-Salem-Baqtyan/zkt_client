# frozen_string_literal: true

require_relative "base"

module ZktClient
  # Transaction class handles operations related to transactions in the ZktClient
  class Transaction < Base
    # URL endpoints for the Transaction resource
    URLS = {
      base: "/iclock/api/transactions/"
    }.freeze

    # Required fields for creating or updating a Transaction resource
    REQUIRED_FEILDS = [].freeze
  end
end
