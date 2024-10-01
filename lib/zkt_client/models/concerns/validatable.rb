# frozen_string_literal: true

module ZktClient
  # Validatable module provides validation methods for ZktClient
  module Validatable
    private

    # Validates the given parameters based on the provided options
    #
    # @param params [Hash] the parameters to validate
    # @param attribute [Symbol] the attribute to validate
    # @param options [Hash] the validation options
    # @option options [Boolean] :required whether the attribute is required
    # @option options [Boolean] :blank whether the attribute can be blank
    # @option options [Class] :type the expected type of the attribute
    # @option options [Array] :in the allowed values for the attribute
    # @raise [ArgumentError] if validation fails
    # @return [void]
    def validate!(params, attribute, **options)
      raise(ArgumentError, "Params must be hash") unless params.is_a?(Hash)

      validate_required!(params, attribute, options)
      validate_blank!(params, attribute, options)
      validate_value!(params, attribute, options)
      validate_type!(params, attribute, options)
    end

    # Validates that the attribute is present if required
    #
    # @param params [Hash] the parameters to validate
    # @param attribute [Symbol] the attribute to validate
    # @param options [Hash] the validation options
    # @option options [Boolean] :required whether the attribute is required
    # @raise [ArgumentError] if the attribute is required but not present
    # @return [void]
    def validate_required!(params, attribute, options)
      return unless options[:required] && !params.key?(attribute)

      raise(ArgumentError, "#{attribute} is required")
    end

    # Validates that the attribute is not blank if blank is not allowed
    #
    # @param params [Hash] the parameters to validate
    # @param attribute [Symbol] the attribute to validate
    # @param options [Hash] the validation options
    # @option options [Boolean] :blank whether the attribute can be blank
    # @raise [ArgumentError] if the attribute is blank but blank is not allowed
    # @return [void]
    def validate_blank!(params, attribute, options)
      return unless !options[:blank] && (params.key?(attribute) && params[attribute].blank?)

      raise(ArgumentError, "#{attribute} can't be blank")
    end

    # Validates that the attribute is of the expected type
    #
    # @param params [Hash] the parameters to validate
    # @param attribute [Symbol] the attribute to validate
    # @param options [Hash] the validation options
    # @option options [Class] :type the expected type of the attribute
    # @raise [ArgumentError] if the attribute is not of the expected type
    # @return [void]
    def validate_type!(params, attribute, options)
      klass_type = options[:type]

      return unless klass_type.to_s.present? && !params[attribute].is_a?(klass_type)

      raise(ArgumentError, "#{attribute} must be #{klass_type}")
    end

    # Validates that the attribute's value is within the allowed values
    #
    # @param params [Hash] the parameters to validate
    # @param attribute [Symbol] the attribute to validate
    # @param options [Hash] the validation options
    # @option options [Array] :in the allowed values for the attribute
    # @raise [ArgumentError] if the attribute's value is not within the allowed values
    # @return [void]
    def validate_value!(params, attribute, options)
      return unless params[attribute].to_s.present? && options[:in]&.exclude?(params[attribute])

      raise(ArgumentError, "#{attribute} must be in #{options[:in]}")
    end
  end
end
