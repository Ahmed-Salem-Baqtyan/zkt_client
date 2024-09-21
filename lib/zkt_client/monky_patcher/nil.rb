# frozen_string_literal: true

require_relative "base"

class NilClass
  include Base

  def blank?
    true
  end
end
