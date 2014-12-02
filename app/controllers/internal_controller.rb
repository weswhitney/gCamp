class InternalController < ApplicationController

  before_action :ensure_current_user
  before_action :projects

  private

  def ensure_current_user
    redirect_to signin_path, notice: "You must be logged in to access that action"
  end

  def projects
    @projects = Project.all
  end
end
