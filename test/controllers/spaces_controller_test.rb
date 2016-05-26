require 'test_helper'

class SpacesControllerTest < ActionDispatch::IntegrationTest
  # TODO: make useful tests

  setup do
    @space = spaces(:one)
    @admin = users(:admin)
    @user = users(:normal)
  end

  test 'index should not be restricted' do
    get spaces_path
    assert_response :success
  end

  test 'show should be restricted' do
    get space_path(@space)
    assert_response 401
  end

  test 'show should be access by any user' do
    get space_path(@space), headers: { Authorization: token_for(@user) }
    assert_response :success
  end

  # test 'should create spaces' do
  #   assert_difference('Space.count') do
  #     post spaces_path,
  #          params: { space: { name: Faker::Name.name } },
  #          headers: { Authorization: token_for(@current_user) }
  #   end

  #   assert_response 201
  # end

  # test 'should update space' do
  #   patch space_path(@space),
  #         params: { space: { name: Faker::Name.name } },
  #         headers: { Authorization: token_for(@current_user) }
  #   assert_response 200
  # end

  # test 'should destroy space' do
  #   assert_difference('space.count', -1) do
  #     delete space_path(@space),
  #            headers: { Authorization: token_for(@current_user) }
  #   end

  #   assert_response :ok
  # end
end
