class ApplicationController < ActionController::Base
  before_action :ensure_current_user
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    User.find_by(id: session[:user_id])
  end

  def ensure_current_user
    unless current_user
      redirect_to signin_path, notice: "You must be logged in to access that action"
    end
  end

  # def task_membership_match
  #   if current_user.memberships.where(project_id: @project.id).present?
  #     true
  #   else
  #     render file: 'public/404.html', status: :not_found, layout: false
  #   end
  # end


  helper_method :current_user

end
