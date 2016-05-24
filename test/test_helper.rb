ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

module ActiveSupport
  class TestCase
    # Setup all fixtures in test/fixtures/*.yml
    # for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    def token_for(user)
      "Bearer #{AuthToken.encode(user.token_payload)}"
    end
  end
end
