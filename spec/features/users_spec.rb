require 'rails_helper'

feature "Users" do

  scenario "User creates a user" do

    visit "/users"
    click_on "Create User"
    fill_in "First name", with: "Jobe"
    fill_in "Last name", with: "Example"
    fill_in "Email", with: "jobe@example.com"
    fill_in "Password", with: "pass"
    fill_in "Password Confirmation", with: "pass"
    click_on "Create User"

    expect(page).to have_content("User was successfully created")
    expect(page).to have_content("Jobe")

  end

  # scenario "User sees show user" do
  #
  #   User.create!(
  #     first_name: "Jobe" , last_name: "Example" , email: "gob@job.com"
  #   )
  #
  #   visit "/users"
  #   click_on "Show"
  #   expect(page).to have_content("Jobe")
  #
  # end
  #
  # scenario "User edits a user" do
  #
  #   User.create!(
  #     first_name: "Jobe" , last_name: "Example" , email: "gob@job.com"
  #   )
  #
  #   visit "/users"
  #   click_on "Edit"
  #   click_on "Update User"
  #
  #   expect(page).to have_content("User was successfully updated")
  #   expect(page).to have_content("Jobe")
  #
  # end
  #
  # scenario "User deletes a user" do
  #
  #   User.create!(
  #     first_name: "Jobe" , last_name: "Example" , email: "gob@job.com"
  #   )
  #
  #
  #   visit "/users"
  #   click_on "Delete"
  #   expect(page).to have_content("User was successfully destroyed")
  #   expect(page).to have_no_content("Jobe")
  #
  # end
  #
end
