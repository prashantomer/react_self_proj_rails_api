require 'test_helper'

class AmenityTest < ActiveSupport::TestCase
  test 'does not allow duplicates' do
    one = Amenity.create(name: 'TestAmenity')
    two = Amenity.create(name: 'TestAmenity')

    assert one.persisted?
    assert !two.persisted?
  end

  test 'name must not be blank' do
    one = Amenity.create(name: '')
    assert one.errors.is_a? ActiveModel::Errors
    assert_equal one.persisted?, false
  end
end
