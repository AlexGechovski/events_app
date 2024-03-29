class EventsController < ApplicationController
  load_and_authorize_resource
  # before_action :set_event, only: %i[ show edit update destroy ]

  # GET /events
  def index
    if current_user != nil
      @attendances = Attendance.where(user_id: current_user.id)
    end

    if params[:query].present?
      @pagy, @events = pagy(Event.where("title LIKE ?", "%#{params[:query]}%"), items: 6)
    else
      @pagy, @events = pagy(Event.all, items: 6)
    end
  end

  # GET /events/1
  def show
    @attendances = Attendance.where(event_id: @event.id)
    if current_user != nil
      @attendance = Attendance.where(event_id: @event.id, user_id: current_user.id).first
    end
  end

  # GET /events/new
  def new
    # @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  def create
    # @event = Event.new(event_params)
    @event.user_id = current_user.id
    respond_to do |format|
      if @event.save
        format.html { redirect_to event_url(@event), notice: "Event was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to event_url(@event), notice: "Event was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:title, :description, :location, :start_date, :end_date, :image)
    end

    def current_ability
      @current_ability ||= EventAbility.new(current_user)
    end
end
