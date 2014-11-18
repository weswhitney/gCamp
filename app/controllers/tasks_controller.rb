class TasksController < ApplicationController
  before_action do
    @project = Project.find(params[:project_id])
  end

  def index
    if params[:complete]
     @tasks = @project.tasks.order(params[:sort_by])
    else
     @tasks = @project.tasks.order(params[:sort_by]).where(complete: false)
    end
  end

  def show
    @task = @projects.tasks.find(params[:id])
  end

  def new
    @task = @project.tasks.new
  end

  def edit
    @task = @projects.tasks.find(params[:id])
  end

  def create
    @task = @project.tasks.new(params.require(:task).permit(:description, :complete, :due_date))
    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      render new_task_path
    end
  end

  def update
    @task = @projects.tasks.find(params[:id])
    @task.update(params.require(:task).permit(:description, :complete, :due_date))
    redirect_to @task, notice: 'Task was successfully updated.'
  end

  def destroy
    @task = @projects.tasks.find(params[:id])
    @task.destroy
    redirect_to @task, notice: 'Task was successfully destroyed.'
  end

end
