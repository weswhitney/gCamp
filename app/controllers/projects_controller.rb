class ProjectsController < ApplicationController

  before_action :require_login
  before_action :only => [:show] do
    set_project
    if current_user.admin || @project.users.include?(current_user)
    else
      raise AccessDenied
    end
  end

  before_action :only => [:edit, :update, :destroy] do
    set_project
    if current_user.admin || owner?(@project, current_user)
    else
      raise AccessDenied
    end
  end

  def index
    @projects = Project.all
    tracker_api = TrackerApi.new
    @tracker_projects = tracker_api.projects(current_user.pivotal_tracker_token)
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def edit
    @project = Project.find(params[:id])
  end

  def create
    @project = Project.new(params.require(:project).permit(:name))
    if @project.save
      Membership.create(
      project: @project,
      user: current_user,
      role: 'owner'
      )
      redirect_to project_tasks_path(@project), notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  def update
    @project = Project.find(params[:id])
    project_params = params.require(:project).permit(:name)
    if @project.update(project_params)
      redirect_to project_path, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path, notice: 'Project was successfully deleted'
  end

  private

  def owner?(project, current_user)
    project.memberships.where(user_id: current_user.id, role: 'owner').count > 0

    result = false
    project.memberships.each do |membership|
      if membership.role == "owner" && current_user.id == membership.user_id
        result = true
      end
    end
    result
  end

  def set_project
    @project = Project.find(params[:id])
  end

end
