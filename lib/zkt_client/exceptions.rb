# frozen_string_literal: true

module ZktClient
  class Error < StandardError; end
  class MissingConfigurationError < Error; end
  class RecordNotFound < Error; end
  class BadRequestError < Error; end
  class UnprocessableEntityError < Error; end
  class ServerError < Error; end
  class RequestFailedError < Error; end
end
