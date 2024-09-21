# frozen_string_literal: true

require_relative "base"

module ZktClient
  class Transaction < Base
    URLS = {
      base: "/iclock/api/transactions/"
    }.freeze
    REQUIRED_FEILDS = [].freeze
  end
end
