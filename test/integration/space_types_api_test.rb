require 'test_helper'

class SpaceTypesApiTest < ActionDispatch::IntegrationTest
  describe 'index' do
    it 'returns a list of space types' do
      get space_types_path
      payload = JSON.parse(body).with_indifferent_access
      payload[:spaceTypes].count.must_equal SpaceType.count
    end
  end

  describe 'create' do
    it 'responds with :unauthorized when user is not an admin' do
      params = { spaceType: { name: 'SpaceType' } }.to_json
      headers = { CONTENT_TYPE: 'application/json',
                  AUTHORIZATION: token_for(users(:normal)) }

      post space_types_path, params: params, headers: headers

      response.status.must_equal 401
    end

    it 'responds with 201 when user is an admin' do
      params = { spaceType: { name: 'SpaceType' } }.to_json
      headers = { CONTENT_TYPE: 'application/json',
                  AUTHORIZATION: token_for(users(:admin)) }

      post space_types_path, params: params, headers: headers

      response.status.must_equal 201
    end
  end

  describe 'show' do
    setup do
      @space_type = space_types(:one)
    end

    it 'returns a space type' do
      get space_type_path(@space_type)
      payload = JSON.parse(body).with_indifferent_access

      response.status.must_equal 200
      payload[:spaceType][:id].must_equal @space_type.id
    end
  end

  describe 'update' do
    setup do
      @space_type = space_types(:one)
    end

    it 'responds with 200 OK when user is an administrator' do
      params = { spaceType: { name: 'New Type' } }.to_json
      headers = { CONTENT_TYPE: 'application/json',
                  AUTHORIZATION: token_for(users(:admin)) }

      put space_type_path(@space_type), params: params, headers: headers

      response.status.must_equal 200
    end

    it 'responds with the updated space type' do
      params = { spaceType: { name: 'New Type' } }.to_json
      headers = { CONTENT_TYPE: 'application/json',
                  AUTHORIZATION: token_for(users(:admin)) }

      put space_type_path(@space_type), params: params, headers: headers

      json = JSON.parse(body).with_indifferent_access
      assert_equal json['spaceType']['name'], 'New Type'
    end

    it 'responds with 401 unauthorized when user is not administrator' do
      put space_type_path(@space_type),
          params: { spaceType: { name: 'New Type' } }.to_json,
          headers: {
            CONTENT_TYPE: 'application/json',
            AUTHORIZATION: token_for(users(:normal))
          }

      response.status.must_equal 401
    end
  end

  describe 'delete' do
    setup do
      @space_type = space_types(:one)
      @admin_user = users(:admin)
    end

    it 'responds with 200 OK when user is an administrator' do
      delete space_type_path(@space_type),
             headers: { Authorization: token_for(@admin_user) }

      response.status.must_equal 200
    end

    it 'responds with 401 unauthorized when user is not administrator' do
      delete space_type_path(@space_type)

      response.status.must_equal 401
    end
  end

  describe 'Serialization' do
    setup do
      @space_type = space_types(:one)
    end

    it 'response should be camelCase' do
      get space_type_path(@space_type)
      json = JSON.parse(body)
      assert_equal json.keys, ['spaceType']
    end

    it 'returns only id and name' do
      get space_type_path(@space_type)
      json = JSON.parse(body)
      assert_equal json['spaceType'].keys, %w(id name)
    end
  end
end
