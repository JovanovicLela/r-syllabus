class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  
  include PublicActivity::StoreController #save current_user using gem public_activity
  
  include Pagy::Backend

  
  include Pundit::Authorization
  protect_from_forgery
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized #pundit
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back(fallback_location: root_path)
  end
  
end
