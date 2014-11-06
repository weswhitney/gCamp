class ProjectsController < ApplicationController


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
    @project.save
    redirect_to project_path(@project), notice: 'Project was successfully created.'
  end

  def update
    @project = Project.find(params[:id])
    project_params = params.require(:project).permit(:name)
    @project.update(project_params)
    redirect_to project_path, notice: 'Project was successfully updated.'
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path, notice: 'Project was successfully deleted'
  end
end
