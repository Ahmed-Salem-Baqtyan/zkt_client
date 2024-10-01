# frozen_string_literal: true

require_relative "base"

# Extends the Array class with additional methods
class Array
  include Base

  # Wraps the given object in an array.
  #
  # @param object [Object] the object to wrap
  # @return [Array] the wrapped object as an array
  def self.wrap(object)
    if object.respond_to?(:to_a)
      object.to_a
    else
      [object]
    end
  end

  # Checks if the array excludes the given value.
  #
  # @param value [Object] the value to check
  # @return [Boolean] true if the array does not include the value, false otherwise
  def exclude?(value)
    !include?(value)
  end
end
