require 'rails_helper'

feature "Users" do

  scenario "User creates a user" do

    visit "/users"
    click_on "Create User"
    fill_in "First name", with: "Jobe"
    fill_in "Last name", with: "Example"
    fill_in "Email", with: "jobe@example.com"
    fill_in "Password", with: "pass"
    fill_in "Password confirmation", with: "pass"
    click_on "Create User"

    expect(page).to have_content("User was successfully created")

  end

  scenario "User sees show user" do

    User.create!(
      first_name: "Jobe",
      last_name: "Example",
      email: "gob@job.com",
      password: "1234",
      password_confirmation: "1234"
    )

    visit "/users"
    click_on "Jobe Example"
    expect(page).to have_content("Jobe")

  end

  scenario "User edits a user" do

    User.create!(
      first_name: "Jobe",
      last_name: "Example",
      email: "gob@job.com",
      password: "1234",
      password_confirmation: "1234"
    )

    visit "/users"
    click_on "edit"
    fill_in "First name", with: "Gob"
    click_on "Update User"

    expect(page).to have_content("User was successfully updated")
    expect(page).to have_content("Gob")

  end

  scenario "User deletes a user" do

    User.create!(
      first_name: "Jobe",
      last_name: "Example",
      email: "gob@job.com",
      password: "1234",
      password_confirmation: "1234"
    )


    visit "/users"
    click_on "Jobe Example"
    click_on "Edit"
    click_on "delete user"
    expect(page).to have_content("User was successfully deleted")
    expect(page).to have_no_content("Jobe")

  end

end
