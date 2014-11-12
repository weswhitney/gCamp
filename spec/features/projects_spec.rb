require 'rails_helper'

feature "Projects" do

  scenario "User creates a project" do

    visit "/projects"
    click_on "Create Project"
    fill_in "Name", with: "Awes proj"
    click_on "Create Project"

    expect(page).to have_content("Project was successfully created.")

  end

  scenario "User tries to create a project with no name" do

    visit "/projects"
    click_on "Create Project"
    click_on "Create Project"

    expect(page).to have_content("Name can't be blank")

  end

  scenario "User sees project" do

    Project.create!(
      name: "Awesome"
    )

    visit "/projects"
    click_on "Awesome"
    expect(page).to have_content("Awesome")

  end

  scenario "User edits a project" do

    Project.create!(
      name: "Awesome"
    )

    visit "/projects"
    click_on "edit"
    fill_in "Name", with: "Awesomeness"
    click_on "Update Project"

    expect(page).to have_content("Project was successfully updated")
    expect(page).to have_content("Awesomeness")

  end

  scenario "User deletes a project" do

    Project.create!(
      name: "Awesome"
    )


    visit "/projects"
    click_on "edit"
    click_on "Update Project"
    click_on "Delete"
    expect(page).to have_content("Project was successfully deleted")
    expect(page).to have_no_content("Awesome")

  end

end
