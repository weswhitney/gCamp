require 'rails_helper'

describe ProjectsController do
  describe "#index" do
    it "redirects visitor to login page if they try to access projects" do
      get :index
      expect(response).to redirect_to(sign_in_path)
    end
  end

  describe "#edit" do
    it "allows owners to edit" do
      user = create_user
      project = create_project
      membership = create_owner(user, project)
      session[:user_id] = user.id
      get :edit, id: project.id
      expect(response).to be_success
    end

    it "does not allow members to edit" do
     user = create_user
     project = create_project
     membership = create_member(user, project)
     session[:user_id] = user.id
     get :edit, id: project.id
     expect(response.status).to eq(404)
    end
  end
end
