class ProjectsController < ApplicationController

  before_action :ensure_current_user

  def index
    @projects = Project.all
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

end
