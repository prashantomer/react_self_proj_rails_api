require 'test_helper'

class SpacesApiTest < ActionDispatch::IntegrationTest

  # example test case for GET /spaces
  describe "get /spaces" do

    it "returns a list of spaces" do
      get "/spaces"
      response.success?.must_equal true

      list = Space.all
      resp = JSON.parse body

      resp["spaces"].count.must_equal list.count
    end

    it "serializes each space with ActiveModel::Serializer" do
      space = Space.first
      serializer = SpaceSerializer.new(space)
      adapter = ActiveModelSerializers::Adapter.create(serializer)

      get "/spaces/#{space.id}"

      adapter.to_json.must_equal body
    end
  end
end
