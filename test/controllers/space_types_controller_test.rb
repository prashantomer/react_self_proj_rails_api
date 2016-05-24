require 'test_helper'

class SpaceTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @space_type = space_types(:one)
    @current_user = users(:admin)
  end

  test 'should get index' do
    get space_types_path
    assert_response :success
  end

  test 'should show space_type' do
    get space_type_path(@space_type)
    assert_response :success
  end

  test 'should create space_types' do
    assert_difference('SpaceType.count') do
      post space_types_path,
           params: { space_type: { name: Faker::Name.name } },
           headers: { Authorization: token_for(@current_user) }
    end

    assert_response 201
  end

  test 'should update space_type' do
    patch space_type_path(@space_type),
          params: { space_type: { name: Faker::Name.name } },
          headers: { Authorization: token_for(@current_user) }
    assert_response 200
  end

  test 'should destroy space_type' do
    assert_difference('SpaceType.count', -1) do
      delete space_type_path(@space_type),
             headers: { Authorization: token_for(@current_user) }
    end

    assert_response :ok
  end
end
