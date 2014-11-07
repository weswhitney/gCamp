require 'rails_helper'

feature "Sign in" do

  scenario "User signs in" do

    User.create!(
      email: "joe@email.com" , password: "1234"
    )


    visit '/sign-in'
    fill_in "Email", with: "joe@email.com"
    fill_in "Password", with: "1234"
    click_on "Sign in"

    expect(page).to have_content("Sign Out")
  end

  scenario "User signs in" do

    User.create!(
      email: "joe@email.com" , password: "1234"
    )


    visit '/sign-in'
    fill_in "Email", with: "joe@email.com"
    fill_in "Password", with: "1235"
    click_on "Sign in"

    expect(page).to have_content("Username / password combination is invalid")
  end



end
