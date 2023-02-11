class AttendancesController < ApplicationController
    def create
      @attendance = Attendance.new(attendance_params)
      @attendance.user_id = current_user.id
      if @attendance.save
        redirect_to @attendance.event
      else
        redirect_to @attendance.event, notice: "Could not attend event."
      end
    end
  
    def destroy
      @attendance = Attendance.find(params[:id])
      @attendance.destroy
      redirect_to @attendance.event
    end
  
    private
  
    def attendance_params
      params.require(:attendance).permit(:user_id, :event_id)
    end
  end