class FollowsController < ApplicationController
  before_action :set_follow, only: %i[ show edit update destroy ]

  # GET /follows or /follows.json
  def index
    @follows = Follow.where(followed_id: params[:user_id])
    respond_to do |format|
      format.json { render json: @follows }
    end
  end

  # GET /follows/1 or /follows/1.json
  def show
    @follow = Follow.where(id: params[:id], follower_id: params[:user_id])
    respond_to do |format|
      format.json { render json: @follow }
    end
  end

  # POST /follows or /follows.json
  def create
    @follow = Follow.new(follow_params)

    respond_to do |format|
      if @follow.save
        format.json { render json: @follow, status: :created }
      else
        format.json { render json: @follow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /follows/1 or /follows/1.json
  def destroy
    @follow.destroy

    respond_to do |format|
      format.html { redirect_to follows_path, status: :see_other, notice: "Follow was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_follow
      @follow = Follow.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def follow_params
      params.require(:follow).permit(:follower_id, :followed_id)
    end
end
