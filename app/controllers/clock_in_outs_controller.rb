class ClockInOutsController < ApplicationController
  before_action :set_clock_in_out, only: %i[ show edit update destroy ]
  before_action :set_user

  # GET /clock_in_outs or /clock_in_outs.json
  def index
    @clock_in_outs = ClockInOut.find_by_user_ordered_created_at(@user.id)
    respond_to do |format|
      format.json { render json: @clock_in_outs, status: 200 }
    end
  end

  def clock_in
    @record = ClockInOut.clock_in(@user.id)
    respond_to do |format|
      if @record.errors.empty?
        format.json { render json: @record, status: :ok }
      else
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
    return
  end

  def clock_out
    record = ClockInOut.clock_out(@user.id)
    respond_to do |format|
      if record.errors.empty?
        format.json { render json: @record, status: :ok }
      else
        format.json { render json: record.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clock_in_out
      @clock_in_out = ClockInOut.find(params[:id])
    end

    def set_user
      if params[:user_id].present?
        @user = User.find params[:user_id]
      else
          raise ArgumentError, "Undefined user or ID #{params[:user_id]}"
      end
    end
end
