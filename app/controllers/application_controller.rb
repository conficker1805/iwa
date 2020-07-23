class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to users_url, alert: exception.message
  end

  protected

  def id
    params.require(:id)
  end
end
