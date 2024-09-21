module ZktClient
  module Validatable
    private

    def validate!(params, attribute, **options)
      raise(ArgumentError, "Params must be hash") unless params.is_a?(Hash)

      validate_required!(params, attribute, options)
      validate_blank!(params, attribute, options)
      validate_value!(params, attribute, options)
      validate_type!(params, attribute, options)
    end

    def validate_required!(params, attribute, options)
      if options[:required] && !params.has_key?(attribute)
        raise(ArgumentError, "#{attribute} id required")
      end
    end

    def validate_blank!(params, attribute, options)
      if !options[:blank] && (params.has_key?(attribute) && params[attribute].blank?)
        raise(ArgumentError, "#{attribute} can't be blank")
      end
    end

    def validate_type!(params, attribute, options)
      unless params[attribute].is_a?(options[:type])
        raise(ArgumentError, "#{attribute} must be #{options[:type]}")
      end
    end

    def validate_value!(params, attribute, options)
      if options[:in]&.exclude?(params[attribute])
        raise(ArgumentError, "#{attribute} must be in #{options[:in]}")
      end
    end
  end
end
