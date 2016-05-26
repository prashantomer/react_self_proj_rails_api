require 'test_helper'

class SpacesApiTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:normal)
    @admin = users(:admin)
    @user_headers = { CONTENT_TYPE: 'application/json',
                      AUTHORIZATION: token_for(@user) }
    @admin_headers = { CONTENT_TYPE: 'application/json',
                       AUTHORIZATION: token_for(@admin) }
  end

  # example test case for GET /spaces
  describe 'index' do
    it 'returns a list of spaces' do
      get '/spaces'
      response.success?.must_equal true

      list = Space.all
      resp = JSON.parse body

      resp['spaces'].count.must_equal list.count
    end
  end

  describe 'show' do
    it 'should be restricted' do
      space = Space.first
      get "/spaces/#{space.id}"
      response.status.must_equal 401
    end

    it 'serializes each space with ActiveModel::Serializer' do
      space = Space.first
      serializer = SpaceSerializer.new(space)
      adapter = ActiveModelSerializers::Adapter.create(serializer)

      get "/spaces/#{space.id}", headers: @user_headers

      adapter.to_json.must_equal body
    end
  end

  describe 'create' do
    setup do
      space_type_id = SpaceType.create(name: Faker::Name.name).id
      @params = { space:
                  { space_type_id: space_type_id,
                    title: Faker::Name.title,
                    address_line_1: Faker::Address.street_address,
                    city: Faker::Address.city,
                    country: Faker::Address.country,
                    latitude: Faker::Address.latitude,
                    longitude: Faker::Address.longitude } }.to_json
    end

    it 'should be restricted' do
      post spaces_path(@space), params: @params
      response.status.must_equal 401
    end

    it 'responds with 201 when user is normal user' do
      post spaces_path, params: @params, headers: @user_headers

      response.status.must_equal 201
    end

    it 'responds with 201 when user is an admin' do
      post spaces_path, params: @params, headers: @admin_headers

      response.status.must_equal 201
    end
  end

  describe 'update' do
    setup do
      @space_type_id = SpaceType.create(name: Faker::Name.name).id
      @params = { space:
                  { space_type_id: @space_type_id,
                    title: Faker::Name.title,
                    address_line_1: Faker::Address.street_address,
                    city: Faker::Address.city,
                    country: Faker::Address.country,
                    latitude: Faker::Address.latitude,
                    longitude: Faker::Address.longitude } }.to_json
      @space = spaces(:one)
    end

    it 'should be restricted' do
      put space_path(@space), params: @params
      response.status.must_equal 401
    end

    it 'responds with 200 OK when user is an administrator' do
      put space_path(@space), params: @params, headers: @user_headers
      response.status.must_equal 200
    end
  end

  describe 'delete' do
    setup do
      @space = spaces(:one)
    end
    it 'should be restricted' do
      delete space_path(@space)
      response.status.must_equal 401
    end

    it 'responds with 200 OK when user is an administrator' do
      delete space_path(@space),
             headers: @admin_headers

      response.status.must_equal 200
    end
  end
end
