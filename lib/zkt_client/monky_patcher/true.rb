# frozen_string_literal: true

require_relative "base"

class TrueClass
  include Base

  def blank?
    false
  end
end
