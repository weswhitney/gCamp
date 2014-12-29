class MembershipsController < ApplicationController
  before_action do
    @project = Project.find(params[:project_id])
  end
  before_action :authorize_owner, only: [:update]
  before_action :authorize_member

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
    if @membership.update(membership_params)
      redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @membership = Membership.find(params[:id])
    if @membership.destroy
      redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was removed successfully"
    else
      render :index
    end
  end

  private

  def set_membership
    @membership = @project.memberships.find(params[:id])
  end

  def membership_params
    params.require(:membership).permit(:role, :project_id, :user_id)
  end

end
