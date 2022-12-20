class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.all
  end
  def show
    @user = User.find_by_id(params[:id])
  end
end
