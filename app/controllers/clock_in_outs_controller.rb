class ClockInOutsController < ApplicationController
  before_action :set_clock_in_out, only: %i[ show edit update destroy ]

  # GET /clock_in_outs or /clock_in_outs.json
  def index
    @clock_in_outs = ClockInOut.all
  end

  # GET /clock_in_outs/1 or /clock_in_outs/1.json
  def show
  end

  # GET /clock_in_outs/new
  def new
    @clock_in_out = ClockInOut.new
  end

  # GET /clock_in_outs/1/edit
  def edit
  end

  # POST /clock_in_outs or /clock_in_outs.json
  def create
    @clock_in_out = ClockInOut.new(clock_in_out_params)

    respond_to do |format|
      if @clock_in_out.save
        format.html { redirect_to @clock_in_out, notice: "Clock in out was successfully created." }
        format.json { render :show, status: :created, location: @clock_in_out }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @clock_in_out.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clock_in_outs/1 or /clock_in_outs/1.json
  def update
    respond_to do |format|
      if @clock_in_out.update(clock_in_out_params)
        format.html { redirect_to @clock_in_out, notice: "Clock in out was successfully updated." }
        format.json { render :show, status: :ok, location: @clock_in_out }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @clock_in_out.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clock_in_outs/1 or /clock_in_outs/1.json
  def destroy
    @clock_in_out.destroy

    respond_to do |format|
      format.html { redirect_to clock_in_outs_path, status: :see_other, notice: "Clock in out was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clock_in_out
      @clock_in_out = ClockInOut.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def clock_in_out_params
      params.require(:clock_in_out).permit(:target_date, :clock_in, :clock_out, :duration, :user_id)
    end
end
