# frozen_string_literal: true

module Base
  # Checks if the object is blank (empty)
  #
  # @return [Boolean] true if the object is empty, false otherwise
  def blank?
    empty?
  end

  # Checks if the object is present (not blank)
  #
  # @return [Boolean] true if the object is not empty, false otherwise
  def present?
    !blank?
  end
end
