# frozen_string_literal: true

require_relative "base"

# Extends the Integer class with additional methods
class Integer
  include Base

  # Checks if the integer is blank (always false for Integer)
  #
  # @return [Boolean] false, since an integer is never considered blank
  def blank?
    false
  end
end
