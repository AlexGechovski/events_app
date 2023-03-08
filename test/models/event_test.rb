require "test_helper"

class EventTest < ActiveSupport::TestCase
  test "title should be present" do
    event = Event.new(title: "", description: "Description", location: "Location", start_date: DateTime.now, end_date: DateTime.now + 1.day, user: users(:one))
    assert_not event.valid?, "Title is blank"
    event.title = "Title"
    assert event.valid?, "Title is present"
  end

  test "title should be at least 4 characters" do
    event = Event.new(title: "abc", description: "Description", location: "Location", start_date: DateTime.now, end_date: DateTime.now + 1.day, user: users(:one))
    assert_not event.valid?, "Title is too short"
    event.title = "abcd"
    assert event.valid?, "Title is long enough"
  end

  test "title should be no more than 150 characters" do
    event = Event.new(title: "a" * 151, description: "Description", location: "Location", start_date: DateTime.now, end_date: DateTime.now + 1.day, user: users(:one))
    assert_not event.valid?, "Title is too long"
    event.title = "a" * 150
    assert event.valid?, "Title is the right length"
  end

  test "location should be present" do
    event = Event.new(title: "Title", description: "Description", location: "", start_date: DateTime.now, end_date: DateTime.now + 1.day, user: users(:one))
    assert_not event.valid?, "Location is blank"
    event.location = "Location"
    assert event.valid?, "Location is present"
  end

  test "location should be at least 6 characters" do
    event = Event.new(title: "Title", description: "Description", location: "abcde", start_date: DateTime.now, end_date: DateTime.now + 1.day, user: users(:one))
    assert_not event.valid?, "Location is too short"
    event.location = "abcdef"
    assert event.valid?, "Location is long enough"
  end

  test "location should be no more than 150 characters" do
    event = Event.new(title: "Title", description: "Description", location: "a" * 151, start_date: DateTime.now, end_date: DateTime.now + 1.day, user: users(:one))
    assert_not event.valid?, "Location is too long"
    event.location = "a" * 150
    assert event.valid?, "Location is the right length"
  end

  test "start_date should be present" do
    event = Event.new(title: "Title", description: "Description", location: "Location", start_date: nil, end_date: DateTime.now + 1.day, user: users(:one))
    assert_not event.valid?, "Start date is blank"
    event.start_date = DateTime.now
    assert event.valid?, "Start date is present"
  end
  test "end_date should be greater than or equal to start_date" do
    event = Event.new(title: "Title", description: "Description", location: "Location", start_date: DateTime.now, end_date: DateTime.now - 1.day, user: users(:one))
    assert_not event.valid?, "End date is before start date"
    event.end_date = DateTime.now
    assert event.valid?, "End date is same as start date"
    event.end_date = DateTime.now + 1.day
    assert event.valid?, "End date is after start date"
  end
end
