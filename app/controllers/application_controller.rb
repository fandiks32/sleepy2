class ApplicationController < ActionController::Base

  private
  def set_default_page
    @page = params[:page] || 1
    @per_page = params[:per_page] || 10
  end
end
