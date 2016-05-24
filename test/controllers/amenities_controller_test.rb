require 'test_helper'

class AmenitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @amenity = amenities(:one)
    @current_user = users(:admin)
  end

  test 'should get index' do
    get amenities_path
    assert_response :success
  end

  test 'should show amenity' do
    get amenity_path(@amenity)
    assert_response :success
  end

  test 'should create amenities' do
    assert_difference('Amenity.count') do
      post amenities_path,
           params: { amenity: { name: Faker::Name.name } },
           headers: { Authorization: token_for(@current_user) }
    end

    assert_response 201
  end

  test 'should update amenity' do
    patch amenity_path(@amenity),
          params: { amenity: { name: Faker::Name.name } },
          headers: { Authorization: token_for(@current_user) }
    assert_response 200
  end

  test 'should destroy amenity' do
    assert_difference('Amenity.count', -1) do
      delete amenity_path(@amenity),
             headers: { Authorization: token_for(@current_user) }
    end

    assert_response :ok
  end
end
