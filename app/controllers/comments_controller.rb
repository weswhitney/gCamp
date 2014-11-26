class CommentsController < ApplicationController
  before_action do
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:task_id])
  end


  def create
    @comment = @task.comments.new(params.require(:comment).permit(:comment, :task_id, :user_id))
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to project_task_path(@project, @task)
    else
      render project_task_path(@project, @task)
    end
  end

end
