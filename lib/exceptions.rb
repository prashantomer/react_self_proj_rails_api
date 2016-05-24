module Exceptions
  class AuthenticationError < StandardError; end
  class UnauthorizedError < AuthenticationError; end
  class InvalidTokenError < AuthenticationError; end
  class ExpiredTokenError < AuthenticationError; end
end
