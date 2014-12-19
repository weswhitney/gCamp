class MembershipsController < ApplicationController
  before_action do
    @project = Project.find(params[:project_id])
  end

  before_action :require_login

  before_action(:only => [:index]) do
    
    project_member = false

    @project.memberships.each do |membership|
      if membership.user_id == current_user.id
        project_member = true
      end
    end

    unless current_user.admin || project_member
      raise AccessDenied
    end
  end

  before_action :only => [:edit, :update, :destroy] do
    set_membership
    if current_user.admin || owner?(@project, current_user)
    else
      raise AccessDenied
    end
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

  def membership_params
    params.require(:membership).permit(:role, :project_id, :user_id)
  end

end
