require "rails_helper"

describe "User" do
  it "validates the uniqueness of the email address" do
    User.create!(
    email: "joe@example.com",
    first_name: "joe",
    last_name: "smith",
    password: "1234",
    password_confirmation: "1234"
    )

    user = User.new
    user.email = "joe@example.com"
    user.valid?
    expect(user.errors[:email].present?).to eq(true)

    user = User.new
    user.email = "joe@gronky.com"
    user.valid?
    expect(user.errors[:email].present?).to eq(false)
  end

  it "validates uniqueness of email regardless of case sensitivity" do
    User.create!(
    email: "joe@example.com",
    first_name: "joe",
    last_name: "smith",
    password: "1234",
    password_confirmation: "1234"
    )

    user = User.new
    user.email = "Joe@Example.com"
    user.valid?
    expect(user.errors[:email].present?).to eq(false)
  end
end
