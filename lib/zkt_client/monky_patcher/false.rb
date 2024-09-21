# frozen_string_literal: true

require_relative "base"

# Extends the FalseClass with additional methods
class FalseClass
  include Base

  # Checks if the object is blank (always true for FalseClass)
  #
  # @return [Boolean] true, since false is considered blank
  def blank?
    true
  end
end
