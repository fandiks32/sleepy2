class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  private
  def set_default_page
    @page = params[:page] || 1
    @per_page = params[:per_page] || 10
  end
end
