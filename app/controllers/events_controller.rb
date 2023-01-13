class EventsController < ApplicationController
  load_and_authorize_resource
  # efore_action :set_event, only: %i[ show edit update destroy ]

  # GET /events or /events.json
  def index
    # @events = Event.all
  end

  # GET /events/1 or /events/1.json
  def show
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
      params.require(:event).permit(:title, :description, :location, :start_date, :end_date)
    end

    def current_abillity
      EventAbillity.new(current_user)
    end
end
