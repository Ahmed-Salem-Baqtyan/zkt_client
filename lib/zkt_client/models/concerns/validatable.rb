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
      if options[:required] && !params.has_key?(attribute)
        raise(ArgumentError, "#{attribute} is required")
      end
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
      if !options[:blank] && (params.has_key?(attribute) && params[attribute].blank?)
        raise(ArgumentError, "#{attribute} can't be blank")
      end
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
      unless params[attribute].is_a?(options[:type])
        raise(ArgumentError, "#{attribute} must be #{options[:type]}")
      end
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
      if options[:in]&.exclude?(params[attribute])
        raise(ArgumentError, "#{attribute} must be in #{options[:in]}")
      end
    end
  end
end
