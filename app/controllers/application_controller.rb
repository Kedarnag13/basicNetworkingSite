class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  helper_method :current_user

  def record_not_found
    render 'static/record_not_found'
  end

  private

  def current_user
    @current_user ||= Member.find(session[:user_id]) if session[:user_id]
  end

  def authorize
    redirect_to root_path, alert: 'You must be logged in to access this page.' if current_user.nil?
  end

end
