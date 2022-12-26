require "application_system_test_case"

class EventsTest < ApplicationSystemTestCase

  setup do
    @event = events(:one)
  end

  test "non-logged in user can only read events" do
    visit events_path
    assert_selector "h1", text: "Events"
  end

  test "logged in user can manage their own events" do
    # Log in as a user
    visit new_user_session_path
    fill_in "Email", with: "user1@example.com"
    fill_in "Password", with: "password"
    click_on "Log in"

    # Verify that the user is logged in
    assert_text "Signed in successfully."

    # User should be able to create, edit, and delete their own events
    visit events_url
    click_on "New event"
    fill_in "Title", with: "My event"
    click_on "Create Event"
    assert_text "Event was successfully created"

    visit event_url(@event)
    click_on "Edit this event"
    fill_in "Title", with: "Updated title"
    click_on "Update Event"
    assert_text "Event was successfully updated"

    visit event_url(@event)
    click_on "Destroy this event"
    assert_text "Event was successfully destroyed"
  end

  test "admin user can manage all events" do
    # Log in as an admin user
    visit login_path
    fill_in "Email", with: "admin@example.com"
    fill_in "Password", with: "password"
    click_on "Log in"

    # Verify that the user is logged in
    assert_text "Logged in as admin@example.com"

    # Admin user should be able to create, edit, and delete all events
    visit events_url
    click_on "New event"
    fill_in "Title", with: "Admin event"
    click_on "Create Event"
    assert_text "Event was successfully created"

    visit event_url(@event)
    click_on "Edit this event"
    fill_in "Title", with: "Updated title"
    click_on "Update Event"
    assert_text "Event was successfully updated"

    visit event_url(@event)
    click_on "Destroy this event"
    assert_text "Event was successfully destroyed"
  end               
end
