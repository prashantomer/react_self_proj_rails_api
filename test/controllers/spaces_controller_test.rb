require 'test_helper'

class SpacesControllerTest < ActionDispatch::IntegrationTest
  # TODO: make useful tests
  test "index should not be restricted" do
    get spaces_url
    assert_response :ok
  end

end
