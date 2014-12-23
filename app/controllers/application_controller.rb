class ApplicationController < ActionController::Base
  before_action :require_login
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  class AccessDenied < StandardError
  end

  rescue_from AccessDenied, with: :render_404

  private

  def render_404
    render "public/404", status: 404, layout: false
  end

  def current_user
      User.find_by(id: session[:user_id])
  end

  def require_login
    unless current_user
      session[:first_url] = request.url if request.get?
      redirect_to signin_path, notice: "You must be logged in to access that action"
    end
  end

  def authorize_owner
    current_user.owner?(@project)
  end

  def authorize_member
    unless current_user.member?(@project)
      raise AccessDenied
    end
  end

  def redirect_to_previous_url_or_projects
    redirect_to (session[:first_url] || projects_path)
    session.delete(:first_url)
  end

  helper_method :require_login

  helper_method :current_user



end
