class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find_by_id(params[:id])
    @events = Event.where(user_id: @user.id)
    @attended_events = Attendance.where(user_id: @user.id)
  end
end
