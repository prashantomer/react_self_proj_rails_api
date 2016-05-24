require 'test_helper'

class SpaceTypeTest < ActiveSupport::TestCase
  test 'does not allow duplicates' do
    one = SpaceType.create(name: 'DUPLICATE_SPACE_TYPE')
    two = SpaceType.create(name: 'DUPLICATE_SPACE_TYPE')

    assert_equal one.persisted?, true
    assert_equal two.persisted?, false
  end

  test 'name must not be blank' do
    one = SpaceType.create(name: '')
    assert_equal one.persisted?, false
  end
end
