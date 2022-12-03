require "test_helper"

class EventTest < ActiveSupport::TestCase
  test "Should not save event without title" do
    event = Event.new(title: "",
      location: "Sofia,Bulgaria",
      start_date: "2022-12-03 22:08:00 UTC",
      end_date: "2022-12-03 22:08:00 UTC")
    assert_not event.valid?
  end
  test "Title shouldn't be less than 4 characters" do
    event = Event.new(title: "Opa",
      location: "Sofia,Bulgaria",
      start_date: "2022-12-03 22:08:00 UTC",
      end_date: "2022-12-03 22:08:00 UTC")
    assert_not event.valid?
  end
  test "Title shouldn't be more than 150 characters" do
    event = Event.new(title: "ycqzuuzutidbzchpfaacophtwpeubuzphzaeemksvwybhcvltukiscofijdouwdkddnrekaupyjrhvhrertcfvmmqbfskkpomumfhqgclaeewqlwioapkoujjhfrkooaphhpobrlkmlhqhpjpgfinlz",
      location: "Sofia,Bulgaria",
      start_date: "2022-12-03 22:08:00 UTC",
      end_date: "2022-12-03 22:08:00 UTC")
    assert_not event.valid?
  end
  test "Should save event with title" do
    event = Event.new(title: "Test Event",
      location: "Sofia,Bulgaria",
      start_date: "2022-12-03 22:08:00 UTC",
      end_date: "2022-12-03 22:08:00 UTC")
    assert event.valid?
  end
  test "Should not save event without start date" do
    event = Event.new(title: "Test Event",
      location: "Sofia,Bulgaria",
      start_date: "",
      end_date: "2022-12-03 22:08:00 UTC")
    assert_not event.valid?
  end
  test "Should not save event without end date" do
    event = Event.new(title: "Test Event",
      location: "Sofia,Bulgaria",
      start_date: "2022-12-03 22:08:00 UTC",
      end_date: "")
    assert_not event.valid?
  end
  test "Start date shouldn't be after end date" do
    event = Event.new(title: "Test Event",
      location: "Sofia,Bulgaria",
      start_date: "2022-12-03 22:08:00 UTC",
      end_date: "2022-12-02 22:08:00 UTC")
    assert_not event.valid?
  end
  test "Shouldn't save without location" do
    event = Event.new(title: "Test Event",
      location: "",
      start_date: "2022-12-03 22:08:00 UTC",
      end_date: "2022-12-02 22:08:00 UTC")
    assert_not event.valid?
  end
  test "Location shouldn't be less than 6 characters" do
    event = Event.new(title: "Test Event",
      location: "Sofia",
      start_date: "2022-12-03 22:08:00 UTC",
      end_date: "2022-12-02 22:08:00 UTC")
    assert_not event.valid?
  end
end
