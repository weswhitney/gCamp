class MembershipsController < ApplicationController
  before_action do
    @project = Project.find(params[:project_id])
  end

  before_action :require_login
  before_action :set_membership, only: [:update, :destroy]

  # before_action :authorize_membership
  # before_action :authorize_owner, only: [:new, :create, :edit, :update]


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


  def set_membership
    @membership = @project.memberships.find(params[:id])
  end

  def ensure_project_member
    if current_user.memberships.where(project_id: @project.id).present?
      true
    else
      raise AccessDenied
    end
  end
  # def authorize_membership
  #   if current_user.memberships.where(project_id: @project).present?
  #     true
  #   else
  #     raise AccessDenied
  #   end
  # end

  # def authorize_owner
  #   @project = Project.find(params[:project_id])
  #   unless current_user.is_owner?(@project)
  #     raise AccessDenied
  #   end
  # end
  #
  def membership_params
    params.require(:membership).permit(:role, :project_id, :user_id)
  end

end
