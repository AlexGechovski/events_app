require "test_helper"

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "Should not save event without title" do
    event = Event.new
    assert_not event.save
  end
end
