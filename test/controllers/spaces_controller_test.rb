require 'test_helper'

class SpacesControllerTest < ActionDispatch::IntegrationTest
  # TODO: make useful tests
  test "index should be restricted" do
    get spaces_url
    assert_response :unauthorized
  end

end
