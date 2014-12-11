# def create_user
#   @user = User.create!(
#   email: "joe@email.com",
#   password: "1234",
#   first_name: "Joe",
#   last_name: "Guy"
#   )
# end
#
# def create_membership(project)
#   Membership.create(
#   project: project,
#   user: @user,
#   role: 'owner'
#   )
# end
#
# def create_project
# project = Project.create!(
# name: "Awesome"
# )
# end


def create_project
  Project.create!(name: "#{Faker::Hacker.ingverb.humanize} #{Faker::Hacker.noun.humanize}")
end

# def create_task(options = {})
#   project = options[:project] || create_project
#   Task.create!(description: Faker::Lorem.sentence,
#   due_date: Faker::Time.forward(24),
#   complete: false,
#   project_id: http://project.id,)
# end
#
# def create_user
#   User.create!(
#   first_name: Faker::Name.first_name,
#   last_name: Faker::Name.last_name,
#   email: Faker::Internet.email,
#   password: Faker::Internet.password,)
# end
#
# def create_membership(options = {})
#   project = options[:project] || create_project
#   user = options[:user] || create_user
#   Membership.create!(
#   role: "Member",
#   project_id: http://project.id,
#   user_id: http://user.id,)
# end
#
# def log_user_in(options = {})
#   user = options[:user] || create_user
#   visit root_path
#   click_on "Sign In"
#   fill_in "email", with: user.email
#   fill_in "password", with: user.password
#   click_on "Sign in"
# end
