class TasksController < ApplicationController
  before_action do
    @project = Project.find(params[:project_id])
  end
  before_action :authorize_member
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action do
    if current_user.admin || @project.users.include?(current_user)
    else
      raise AccessDenied
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

  private

  def set_task
    @task = @project.tasks.find(params[:id])
  end
end
