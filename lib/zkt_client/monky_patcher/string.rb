# frozen_string_literal: true

require_relative "base"

# Extends the String class with additional methods
class String
  include Base

  # Checks if the string is blank (empty or contains only whitespace)
  #
  # @return [Boolean] true if the string is empty or contains only whitespace, false otherwise
  def blank?
    strip.empty?
  end
end
