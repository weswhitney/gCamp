class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :authorize_owner, only: [:edit, :update, :destroy]
  before_action :authorize_member

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

  def set_project
    @project = Project.find(params[:id])
  end

end
