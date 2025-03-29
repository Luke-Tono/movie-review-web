class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :require_user, :require_admin

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    unless logged_in?
      flash[:alert] = "Please login first"
      redirect_to login_path
    end
  end

  def require_admin
    unless logged_in? && current_user.admin?
      flash[:alert] = "You don't have permission to access this page"
      redirect_to root_path
    end
  end
end