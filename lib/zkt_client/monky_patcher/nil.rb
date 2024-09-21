# frozen_string_literal: true

require_relative "base"

# Extends the NilClass with additional methods
class NilClass
  include Base

  # Checks if the object is blank (always true for NilClass)
  #
  # @return [Boolean] true, since nil is considered blank
  def blank?
    true
  end
end
