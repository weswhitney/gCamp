require 'rails_helper'

feature "Users" do

  before do
    User.delete_all
    User.create!(
    email: "joe@email.com",
    password: "1234",
    first_name: "Joe",
    last_name: "Guy",
    pivotal_tracker_token: "123xyz"
    )


    visit '/sign-in'
    fill_in "Email", with: "joe@email.com"
    fill_in "Password", with: "1234"
    click_on "Sign in"
  end


  scenario "User creates a user" do

    visit "/users"
    click_on "Create User"
    fill_in "First name", with: "Jobe"
    fill_in "Last name", with: "Example"
    fill_in "Email", with: "jobe@example.com"
    fill_in "Password", with: "pass"
    fill_in "Password confirmation", with: "pass"
    fill_in "Pivotal Tracker Token", with: "123xyz"
    click_on "Create User"

    expect(page).to have_content("User was successfully created")

  end

  scenario "User sees show user" do

    visit "/users"
    click_on("Joe Guy", match: :first)
    expect(page).to have_content("Joe")

  end

  scenario "User edits a user" do

    visit "/users"
    click_on "edit"
    fill_in "First name", with: "Gob"
    click_on "Update User"

    expect(page).to have_content("User was successfully updated")
    expect(page).to have_content("Gob")

  end

  scenario "User deletes a user" do

    visit "/users"
    click_on("Joe Guy", match: :first)
    click_on "Edit"
    click_on "delete user"
    expect(page).to have_content("User was successfully deleted")
    expect(page).to have_no_content("Joe")

  end

end
