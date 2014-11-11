class TasksController < ApplicationController

  def index
    if params[:complete]
     @tasks = Task.order(params[:sort_by])
    else
     @tasks = Task.order(params[:sort_by]).where(complete: false)
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(params.require(:task).permit(:description, :complete, :due_date))
    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def update
    @task = Task.find(params[:id])
    @task.update(params.require(:task).permit(:description, :complete, :due_date))
    redirect_to @task, notice: 'Task was successfully updated.'
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to @task, notice: 'Task was successfully destroyed.'
  end

end
