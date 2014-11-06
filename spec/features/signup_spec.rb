require 'rails_helper'

feature "Signup" do

  scenario "User signs up" do

    visit root_path
    expect(page).to have_content("gCamp")

    click_on "Sign Up"
    expect(page).to have_content("Sign Up for gCamp!")
    fill_in "First name", with: "My awesome name"
    fill_in "Last name", with: "My awesome last name"
    fill_in "Email", with: "my@email.com"
    fill_in "Password", with: "1234"
    fill_in "Password confirmation"
    click_on "Sign up"

    expect(page).to have_content("My awesome name")
    expect(page).to have_no_content("My aweeesome event")
  end

end
