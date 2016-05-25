require 'test_helper'

class SpacesApiTest < ActionDispatch::IntegrationTest
  before(:each) do
    @user_headers = { CONTENT_TYPE: 'application/json',
                      AUTHORIZATION: token_for(users(:normal)) }
    @admin_headers = { CONTENT_TYPE: 'application/json',
                       AUTHORIZATION: token_for(users(:admin)) }
  end

  # example test case for GET /spaces
  describe 'get /spaces' do
    it 'returns a list of spaces' do
      get '/spaces'
      response.success?.must_equal true

      list = Space.all
      resp = JSON.parse body

      resp['spaces'].count.must_equal list.count
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
    before(:each) do
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
    it 'responds with 201 when user is normal user' do
      post spaces_path, params: @params, headers: @user_headers

      response.status.must_equal 201
    end

    it 'responds with 201 when user is an admin' do
      post spaces_path, params: @params, headers: @admin_headers

      response.status.must_equal 201
    end
  end
end
