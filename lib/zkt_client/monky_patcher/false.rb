# frozen_string_literal: true

require_relative "base"

class FalseClass
  include Base

  def blank?
    true
  end
end
