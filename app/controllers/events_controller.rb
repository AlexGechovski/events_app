class EventsController < ApplicationController
  load_and_authorize_resource
  # before_action :set_event, only: %i[ show edit update destroy ]

  # GET /events or /events.json
  def index
    # @events = Event.all
    if params[:query].present?
      @events = Event.where("title LIKE ?", "%#{params[:query]}%")
    else
      @events = Event.all
    end
  end

  # GET /events/1 or /events/1.json
  def show
    @attendances = Attendance.where(event_id: @event.id)
    @attendance = Attendance.where(event_id: @event.id, user_id: current_user.id).first
  end

  # GET /events/new
  def new
    # @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events or /events.json
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

  # PATCH/PUT /events/1 or /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to event_url(@event), notice: "Event was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_event
    #   # @event = Event.find(params[:id])
    # end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:title, :description, :location, :start_date, :end_date, :image)
    end

    def current_ability
      @current_ability ||= EventAbility.new(current_user)
    end
end
