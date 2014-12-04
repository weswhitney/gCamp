require 'rails_helper'

describe ProjectsController do
  describe "#destroy" do
    before do
      @user = User.create!(
        first_name: "Joe",
        last_name: "Example",
        password: "password",
      )
      @project
    end
  end
end
