# frozen_string_literal: true

require_relative "base"

# Extends the TrueClass with additional methods
class TrueClass
  include Base

  # Checks if the object is blank (always false for TrueClass)
  #
  # @return [Boolean] false, since true is not considered blank
  def blank?
    false
  end
end
