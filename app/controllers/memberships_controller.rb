class MembershipsController < ApplicationController

  before_action :ensure_current_user

  before_action do
    @project = Project.find(params[:project_id])
  end

  def index
    @memberships = @project.memberships.all
    @membership = @project.memberships.new
  end

  def create
    @membership = @project.memberships.new(membership_params)
    if @membership.save
    redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was added successfully"
    else
    render :index
    end
  end

  def update
    @membership = Membership.find(params[:id])
    @membership.update(membership_params)
    redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was updated successfully"

  end

  def destroy
    @membership = Membership.find(params[:id])
    @membership.destroy
    redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was removed successfully"
  end

  private

  def membership_params
    params.require(:membership).permit(:role, :project_id, :user_id)
  end

end
