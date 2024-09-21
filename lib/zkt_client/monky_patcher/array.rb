# frozen_string_literal: true

require_relative "base"

class Array include Base
  def self.wrap(object)
    if object.respond_to?(:to_a)
      object.to_a
    else
      [object]
    end
  end

  def exclude?(value)
    !self.include?(value)
  end
end
