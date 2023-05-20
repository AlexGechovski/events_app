require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "fixtures are valid" do
    assert users(:one).valid?
    assert users(:two).valid?
    assert users(:three).valid?
    assert users(:four).valid?
    assert users(:five).valid?
  end

  # add additional tests as needed...
end