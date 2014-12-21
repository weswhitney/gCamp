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
      redirect_to signin_path, notice: "You must be logged in to access that action"
    end
  end

  def authorize_owner
    current_user.owner?(@project)
  end

  def authorize_member
    current_user.member?(@project)
  end

  helper_method :require_login

  # def task_membership_match
  #   if current_user.memberships.where(project_id: @project.id).present?
  #     true
  #   else
  #     render file: 'public/404.html', status: :not_found, layout: false
  #   end
  # end


  helper_method :current_user

end
