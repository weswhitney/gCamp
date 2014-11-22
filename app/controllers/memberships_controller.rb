class MembershipsController < ApplicationController

  before_action do
    @project = Project.find(params[:project_id])
  end

  def index
    @memberships = Membership.all
    @membership = Membership.new
  end

  def create
    @membership = @project.memberships.new(params.require(:membership).permit(:role, :project_id, :user_id))
    if @membership.save
    redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was added successfully"
    else
    render :index
    end
  end

  def update
    @membership = Membership.find(params[:id])
    @membership.update(params.require(:membership).permit(:role, :project_id, :user_id))
    redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was updated successfully"

  end

  def destroy
    @membership = Membership.find(params[:id])
    @membership.destroy
    redirect_to project_path(@project), notice: "#{@membership.user.full_name} was removed successfully"
  end

end
