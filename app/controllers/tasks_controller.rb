class TasksController < ApplicationController

  before_action :ensure_current_user
  # before_action :task_membership_match, only: [:edit]
  before_action do
    @project = Project.find(params[:project_id])
  end

  before_action do
    unless current_user.memberships.where(project_id: @project.id).present?
      render file: 'public/404.html', status: :not_found, layout: false
    end
  end


  def index
    if params[:show_by] == "all"
      @tasks = @project.tasks.all
    else
      @tasks = @project.tasks.order(params[:sort_by]).where(complete: false)
    end
  end

  def show
    @task = @project.tasks.find(params[:id])
    @comment = @task.comments.new
    @comments = @task.comments.all
  end

  def new
    @task = @project.tasks.new
  end

  def edit
    @task = @project.tasks.find(params[:id])
  end

  def create
    @task = @project.tasks.new(params.require(:task).permit(:description, :complete, :due_date))
    if @task.save
      redirect_to project_tasks_path, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def update
    @task = @project.tasks.find(params[:id])
    if @task.update(params.require(:task).permit(:description, :complete, :due_date))
      redirect_to project_tasks_path, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @task = @project.tasks.find(params[:id])
    @task.destroy
    redirect_to project_tasks_path, notice: 'Task was successfully destroyed.'
  end
end
