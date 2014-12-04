require 'rails_helper'

feature "Tasks" do

  before do
    User.create!(
    email: "joe@email.com",
    password: "1234",
    first_name: "Joe",
    last_name: "Guy"
    )


    visit '/sign-in'
    fill_in "Email", with: "joe@email.com"
    fill_in "Password", with: "1234"
    click_on "Sign in"
  end


  scenario "User creates a task" do
    project1 = Project.create!(
    name: "Awesome Project"
    )
    visit project_tasks_path(project1)
    click_on "Create Task"
    fill_in "Description", with: "My awesome task"
    fill_in "Due date", with: "07/07/2015"
    click_on "Create Task"

    expect(page).to have_content("Task was successfully created")
    expect(page).to have_content("My awesome task")

  end

  scenario "User attempts to create a task with no description" do
    project1 = Project.create!(
    name: "Awesome Project"
    )

    visit project_tasks_path(project1)

    click_on "Create Task"
    click_on "Create Task"
    expect(page).to have_content("Description can't be blank")

  end

  scenario "User sees show page" do
    project1 = Project.create!(
    name: "Awesome Project"
    )

    project1.tasks.create!(
    description: "bowling",
    complete: "false",
    due_date: "11/15/2016"
    )

    visit project_tasks_path(project1)
    expect(page).to have_content("bowling")

  end

  scenario "User edits a task" do
    project1 = Project.create!(
    name: "Awesome Project"
    )

    project1.tasks.create!(
    description: "bowling",
    complete: "false",
    due_date: "11/15/2016"
    )

    visit project_tasks_path(project1)
    click_on "Edit"
    check "Complete"
    click_on "Update Task"

    expect(page).to have_content("Task was successfully updated")

  end

  scenario "User deletes a task" do
    project1 = Project.create!(
    name: "Awesome Project"
    )

    project1.tasks.create!(
    description: "bowling" , complete: "false" , due_date: "11/05/2016"
    )

    visit project_tasks_path(project1)
    find('.glyphicon').click
    expect(page).to have_content("Task was successfully destroyed")

  end

end
