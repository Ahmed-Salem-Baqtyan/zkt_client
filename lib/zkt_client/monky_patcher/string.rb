# frozen_string_literal: true

require_relative "base"

class String
  include Base

  def blank?
    strip.empty?
  end
end
