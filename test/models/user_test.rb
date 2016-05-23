require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'creating a user' do
    user = User.create(name: Faker::Name.name, email: 'test-user@example.com', password: '12341234', password_confirmation: '12341234')
    assert user.persisted?
  end
end
