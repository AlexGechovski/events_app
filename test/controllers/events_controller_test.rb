require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = events(:one)
    @user = users(:one)
  end

  test "should get index" do
    get events_url
    assert_response :success
  end

  test "should get new" do
    # Log in a user
    post new_user_session_path, params: { user: { email: @user.email, password: "password" } }

    get new_event_path
    assert_response :success
  end

  test "should create event" do
    # Log in a user
    post new_user_session_path, params: { user: { email: @user.email, password: "password" } }

    assert_difference("Event.count") do
      post events_url, params: { event: { description: @event.description, end_date: @event.end_date, location: @event.location, start_date: @event.start_date, title: @event.title } }
    end

    assert_redirected_to event_url(Event.last)
  end

  test "should show event" do
    get event_url(@event)
    assert_response :success
  end

  test "should get edit" do
    # Log in a user
    post new_user_session_path, params: { user: { email: @user.email, password: "password" } }

    get edit_event_url(@event)
    assert_response :success
  end

  test "should update event" do
    # Log in a user
    post new_user_session_path, params: { user: { email: @user.email, password: "password" } }

    patch event_url(@event), params: { event: { description: @event.description, end_date: @event.end_date, location: @event.location, start_date: @event.start_date, title: @event.title } }
    assert_redirected_to event_url(@event)
  end

  test "should destroy event" do
    # Log in a user
    post new_user_session_path, params: { user: { email: @user.email, password: "password" } }
    
    assert_difference("Event.count", -1) do
      delete event_url(@event)
    end

    assert_redirected_to events_url
  end
end
