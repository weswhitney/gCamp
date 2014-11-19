Project.delete_all
Task.delete_all
User.delete_all
25.times do
  project = Project.create!(name: "#{Faker::Hacker.ingverb} #{Faker::Hacker.noun}")
    rand(10).times do
      Task.create!(description: Faker::Lorem.sentence,
                  due_date: Faker::Time.forward(24),
                  complete: [true, true, false].sample,
                  project_id: project.id)
                end

    rand(5).times do
      user = User.create!(
                      first_name: Faker::Name.first_name,
                      last_name: Faker::Name.last_name,
                      email: Faker::Internet.email,
                      password_digest: Faker::Internet.password)
                end
end
