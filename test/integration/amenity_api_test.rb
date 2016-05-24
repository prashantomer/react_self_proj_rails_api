require 'test_helper'

class AmenityApiTest < ActionDispatch::IntegrationTest
  describe 'index' do
    it 'returns a list of amenities' do
      get amenities_path
      payload = JSON.parse(body).with_indifferent_access
      payload[:amenities].count.must_equal Amenity.count
    end
  end

  describe 'create' do
    it 'responds with :unauthorized when user is not an admin' do
      params = { Amenity: { name: 'Amenity' } }.to_json
      headers = { CONTENT_TYPE: 'application/json',
                  AUTHORIZATION: token_for(users(:normal)) }

      post amenities_path, params: params, headers: headers

      response.status.must_equal 401
    end

    it 'responds with 201 when user is an admin' do
      params = { Amenity: { name: 'Amenity' } }.to_json
      headers = { CONTENT_TYPE: 'application/json',
                  AUTHORIZATION: token_for(users(:admin)) }

      post amenities_path, params: params, headers: headers

      response.status.must_equal 201
    end
  end

  describe 'show' do
    setup do
      @amenity = amenities(:one)
    end

    it 'returns a space type' do
      get amenity_path(@amenity)
      payload = JSON.parse(body).with_indifferent_access

      response.status.must_equal 200
      payload[:amenity][:id].must_equal @amenity.id
    end
  end

  describe 'update' do
    setup do
      @amenity = amenities(:one)
    end

    it 'responds with 200 OK when user is an administrator' do
      params = { Amenity: { name: 'New Type' } }.to_json
      headers = { CONTENT_TYPE: 'application/json',
                  AUTHORIZATION: token_for(users(:admin)) }

      put amenity_path(@amenity), params: params, headers: headers

      response.status.must_equal 200
    end

    it 'responds with the updated space type' do
      params = { Amenity: { name: 'New Type' } }.to_json
      headers = { CONTENT_TYPE: 'application/json',
                  AUTHORIZATION: token_for(users(:admin)) }

      put amenity_path(@amenity), params: params, headers: headers

      json = JSON.parse(body).with_indifferent_access
      assert_equal json['amenity']['name'], 'New Type'
    end

    it 'responds with 401 unauthorized when user is not administrator' do
      put amenity_path(@amenity),
          params: { Amenity: { name: 'New Type' } }.to_json,
          headers: {
            CONTENT_TYPE: 'application/json',
            AUTHORIZATION: token_for(users(:normal))
          }

      response.status.must_equal 401
    end
  end

  describe 'delete' do
    setup do
      @amenity = amenities(:one)
      @admin_user = users(:admin)
    end

    it 'responds with 200 OK when user is an administrator' do
      delete amenity_path(@amenity),
             headers: { Authorization: token_for(@admin_user) }

      response.status.must_equal 200
    end

    it 'responds with 401 unauthorized when user is not administrator' do
      delete amenity_path(@amenity)

      response.status.must_equal 401
    end
  end

  describe 'Serialization' do
    setup do
      @amenity = amenities(:one)
    end

    it 'response should be camelCase' do
      get amenity_path(@amenity)
      json = JSON.parse(body)
      assert_equal json.keys, ['amenity']
    end

    it 'returns only id and name' do
      get amenity_path(@amenity)
      json = JSON.parse(body)
      assert_equal json['amenity'].keys, %w(id name)
    end
  end
end
