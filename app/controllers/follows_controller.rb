class FollowsController < ApplicationController
  before_action :set_follow, only: %i[ show edit update destroy ]
  before_action :set_default_page, only: %i[ index ]

  # GET /follows or /follows.json
  def followings
    @follows = Follow.where(follower_id: params[:user_id]).page(@page).per(@page)
    respond_to do |format|
      format.json { render json: @follows }
    end
  end

  def followers
    @follows = Follow.where(followed_id: params[:user_id]).page(@page).per(@page)
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

  def unfollow
    if params[:followed_id].blank?
      raise ArgumentError, "undefined followed_id"
    end

    follow = Follow.where(follower_id: params[:user_id], followed_id: params[:followed_id]).first
    if follow.present?
      if follow.destroy
        respond_to do |format|
          format.json { head :no_content }
        end
      else
        respond_to do |format|
          format.json { render json: @follow.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.json { render json: "Cannot perform action, already unfollowed", status: :unprocessable_entity }
      end
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
